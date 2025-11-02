

import 'dart:math';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:monity/data/database.dart';
import 'package:csv/csv.dart';
import 'package:logger/logger.dart';
import 'package:monity/data/default_categories.dart';

class FinanceService {
  final AppDatabase _db;

  FinanceService(this._db);

  Future<void> performMonthlyBudgetAdjustment() async {
    final appSettings = await _db.appSettingsDao.getSettings();
    if (!appSettings.monityControlEnabled) {
      return; // Do nothing if Monity control is disabled
    }

    final allAccounts = await _db.cuentasDao.allCuentas;
    final now = DateTime.now();

    for (final account in allAccounts) {
      if (['Objetivos futuros'].contains(account.nombre)) continue;

      final List<double> spendings = await Future.wait([
        _getSpendingForMonth(account.id, now.year, now.month - 1),
        _getSpendingForMonth(account.id, now.year, now.month - 2),
      ]);
      final double averageSpending = (spendings[0] + spendings[1]) / 2;

      final newMaxBalance = averageSpending * account.maxBalancePercentage;
      final newSpendingLimit = averageSpending * account.adjustmentPercentage;

      final updatedAccount = account.copyWith(
        saldoMaximoMensual: newMaxBalance,
        limiteGastoMensual: newSpendingLimit,
      );
      await _db.cuentasDao.upsertCuenta(updatedAccount.toCompanion(true));
    }
  }

  Future<double> _getSpendingForMonth(int accountId, int year, int month) async {
    final startDate = DateTime(year, month, 1);
    final endDate = DateTime(year, month + 1, 0);

    final transactions = await (_db.transaccionesDao.select(_db.transacciones)
          ..where((tbl) =>
              tbl.idCuenta.equals(accountId) &
              tbl.tipo.equals(TipoTransaccion.gasto.index) &
              tbl.fecha.isBetween(Variable(startDate), Variable(endDate))))
        .get();
    
    // ✅ SOLUCIÓN CON BUCLE FOR
    double totalSpending = 0.0;
    for (final transaction in transactions) {
      totalSpending += transaction.cantidad.abs();
    }
    return totalSpending;
  }


  // --- Métodos de Cálculo de Amortización ---

  double calculateNewPayment(
      double principal, double annualRate, int termInMonths) {
    if (termInMonths <= 0) return principal; // Si no hay plazo, se paga todo
    final double monthlyRate = (annualRate / 100) / 12;
    if (monthlyRate <= 0) return principal / termInMonths;

    final double numerator =
        principal * monthlyRate * pow(1 + monthlyRate, termInMonths);
    final double denominator = pow(1 + monthlyRate, termInMonths) - 1;

    return numerator / denominator;
  }

  int calculateNewTerm(double principal, double annualRate, double payment) {
    if (payment <= 0) return 9999; // Evitar división por cero
    final double monthlyRate = (annualRate / 100) / 12;
    if (monthlyRate <= 0) return (principal / payment).ceil();

    if ((payment - (principal * monthlyRate)) <= 0) return 9999;

    final double logPayment = log(payment);
    final double logInterestPart = log(payment - (principal * monthlyRate));
    final double logTerm = log(1 + monthlyRate);

    return ((logPayment - logInterestPart) / logTerm).ceil();
  }

  Future<void> realizarAportacionExtra(Credito credit, double amount,
      {int? newTerm, double? newPayment}) async {
    if (amount <= 0) return;

    await _db.transaction(() async {
      final categoriaPrestamos = await _db.categoriasDao
          .getCategoryByNameAndType('Préstamos', TipoCategoria.gasto.index);
      final categoriaComisiones = await _db.categoriasDao
          .getCategoryByNameAndType('Otros', TipoCategoria.gasto.index);

      if (categoriaPrestamos == null || categoriaComisiones == null) {
        Logger().e('Categoría no encontrada para realizar aportación extra.');
        return;
      }

      double totalDebit = amount;
      double commission = 0;

      if (credit.comisionAmortizacionParcial != null &&
          credit.comisionAmortizacionParcial! > 0) {
        commission = amount * (credit.comisionAmortizacionParcial! / 100);
        totalDebit += commission;
      }

      if (amount > credit.remainingAmount) {
        amount = credit.remainingAmount;
      }

      double remainingAmountToDebit = totalDebit;
      final now = DateTime.now();

      final allAccounts = await _db.cuentasDao.allCuentas;
      final linkedAccountIndex =
          allAccounts.indexWhere((c) => c.id == credit.linkedAccountId);

      if (linkedAccountIndex == -1) {
        Logger().e('Cuenta vinculada al crédito no encontrada.');
        return;
      }

      // Start from the linked account and iterate through subsequent accounts
      for (int i = linkedAccountIndex;
          i < allAccounts.length && remainingAmountToDebit > 0;
          i++) {
        Cuenta currentAccount = allAccounts[i];

        double amountToDeduct =
            min(remainingAmountToDebit, currentAccount.saldoActual);

        if (amountToDeduct > 0) {
          // Register the expense for the contribution
          final gastoId =
              await _db.gastosDao.insertGasto(GastosCompanion.insert(
            cantidad: amountToDeduct,
            concepto:
                'Aportación extra: ${credit.name} (desde ${currentAccount.nombre})',
            fecha: now,
            idCategoria: categoriaPrestamos.id,
          ));

          await _db.transaccionesDao
              .insertTransaccion(TransaccionesCompanion.insert(
            idCuenta: currentAccount.id,
            cantidad: -amountToDeduct,
            tipo: TipoTransaccion.gasto,
            fecha: now,
            idGasto: Value(gastoId),
          ));

          // Update the account
          final updatedCuenta = currentAccount.copyWith(
            saldoActual: currentAccount.saldoActual - amountToDeduct,
            gastoAcumuladoMes:
                currentAccount.gastoAcumuladoMes + amountToDeduct,
          );
          await _db.cuentasDao.upsertCuenta(updatedCuenta.toCompanion(false));

          remainingAmountToDebit -= amountToDeduct;
        }
      }

      // Handle commission separately if it couldn't be fully covered by the main deduction loop
      if (commission > 0 && remainingAmountToDebit > 0) {
        // Try to deduct remaining commission from any account with balance
        for (int i = 0;
            i < allAccounts.length && remainingAmountToDebit > 0;
            i++) {
          Cuenta currentAccount = allAccounts[i];
          double commissionToDeduct =
              min(remainingAmountToDebit, currentAccount.saldoActual);

          if (commissionToDeduct > 0) {
            final comisionGastoId =
                await _db.gastosDao.insertGasto(GastosCompanion.insert(
              cantidad: commissionToDeduct,
              concepto:
                  'Comisión por aportación: ${credit.name} (desde ${currentAccount.nombre})',
              fecha: now,
              idCategoria: categoriaComisiones.id,
            ));
            await _db.transaccionesDao
                .insertTransaccion(TransaccionesCompanion.insert(
              idCuenta: currentAccount.id,
              cantidad: -commissionToDeduct,
              tipo: TipoTransaccion.gasto,
              fecha: now,
              idGasto: Value(comisionGastoId),
            ));

            final updatedCuenta = currentAccount.copyWith(
              saldoActual: currentAccount.saldoActual - commissionToDeduct,
              gastoAcumuladoMes:
                  currentAccount.gastoAcumuladoMes + commissionToDeduct,
            );
            await _db.cuentasDao.upsertCuenta(updatedCuenta.toCompanion(false));

            remainingAmountToDebit -= commissionToDeduct;
          }
        }
      }

      if (remainingAmountToDebit > 0) {
        Logger().w(
            'No se pudo cubrir completamente la aportación extra de ${totalDebit.toStringAsFixed(2)} para el crédito ${credit.name}. Faltaron ${remainingAmountToDebit.toStringAsFixed(2)}.');
      }

      // Update the credit
      final updatedCredit = credit.copyWith(
        remainingAmount: credit.remainingAmount - amount,
        plazoEnMeses: newTerm,
        paymentAmount: newPayment,
      );
      await _db.creditosDao.upsertCredito(updatedCredit.toCompanion(false));

      Logger().i(
          'Aportación extra de $amount para el crédito ${credit.name} procesada con una comisión de $commission.');
    });
  }

  Future<void> checkAndExecuteCreditPayments() async {
    Logger().d('Checking and executing credit payments...');
    final now = DateTime.now();
    final allCredits = await _db.creditosDao.allCreditos;
    final categoriaPrestamos = await _db.categoriasDao
        .getCategoryByNameAndType('Préstamos', TipoCategoria.gasto.index);

    if (categoriaPrestamos == null) {
      Logger().e(
          'Default category "Préstamos" not found. Skipping credit payments.');
      return;
    }

    for (final credit in allCredits) {
      if (credit.remainingAmount <= 0) continue;

      DateTime lastPayment = credit.lastPaymentDate ?? credit.createdAt;

      // Determine the year and month of the next payment
      int nextPaymentYear = lastPayment.year;
      int nextPaymentMonth = lastPayment.month;

      if (lastPayment.day >= credit.paymentDay) {
        nextPaymentMonth++;
        if (nextPaymentMonth > 12) {
          nextPaymentMonth = 1;
          nextPaymentYear++;
        }
      }

      // Determine the day of the next payment, handling months with fewer days
      int daysInMonth = DateTime(nextPaymentYear, nextPaymentMonth + 1, 0).day;
      int nextPaymentDay = credit.paymentDay > daysInMonth ? daysInMonth : credit.paymentDay;

      DateTime nextPaymentDate = DateTime(nextPaymentYear, nextPaymentMonth, nextPaymentDay);

      if (now.isAfter(nextPaymentDate) || now.isAtSameMomentAs(nextPaymentDate)) {
        final alreadyPaidThisMonth = credit.lastPaymentDate != null &&
            credit.lastPaymentDate!.year == now.year &&
            credit.lastPaymentDate!.month == now.month;

        if (alreadyPaidThisMonth) continue;

        Logger().i('Processing payment for credit: ${credit.name}');

        final paymentAmount = (credit.paymentAmount < credit.remainingAmount)
            ? credit.paymentAmount
            : credit.remainingAmount;

        final success = await agregarGasto(
          paymentAmount,
          'Pago crédito: ${credit.name}',
          categoriaPrestamos.id,
          credit.linkedAccountId,
          now,
        );

        if (success) {
          final updatedCredit = credit.copyWith(
            remainingAmount: credit.remainingAmount - paymentAmount,
            lastPaymentDate: Value(now),
          );
          await _db.creditosDao.upsertCredito(updatedCredit.toCompanion(false));
          Logger().i('Credit payment for ${credit.name} processed successfully.');
        } else {
          Logger().w(
              'Credit payment for ${credit.name} failed due to insufficient funds.');
        }
      }
    }
  }

  Future<void> agregarIngreso(double cantidadTotal, int idCategoria,
      int selectedAccountId, DateTime selectedDate) async {
    final fecha = selectedDate;
    final ingresoId =
        await _db.ingresosDao.insertIngreso(IngresosCompanion.insert(
      cantidadTotal: cantidadTotal,
      fecha: fecha,
      idCategoria: idCategoria,
    ));

    final cuentas = await _db.cuentasDao.allCuentas;
    var cantidadRestante = cantidadTotal;

    // Find the starting account based on selectedAccountId
    final startIndex = cuentas.indexWhere((c) => c.id == selectedAccountId);
    if (startIndex == -1) {
      Logger().e('Error: Cuenta seleccionada para ingreso no encontrada.');
      return; // Or handle this error appropriately
    }

    for (int i = startIndex; i < cuentas.length; i++) {
      if (cantidadRestante <= 0) break;

      final cuenta = cuentas[i];
      final espacioParaIngresar =
          (cuenta.saldoMaximoMensual - cuenta.sobranteMesAnterior)
                  .clamp(0, double.infinity) -
              cuenta.ingresoAcumuladoMes;

      if (espacioParaIngresar > 0) {
        final cantidadAIngresar = cantidadRestante < espacioParaIngresar
            ? cantidadRestante
            : espacioParaIngresar;

        await _db.transaccionesDao
            .insertTransaccion(TransaccionesCompanion.insert(
          idCuenta: cuenta.id,
          cantidad: cantidadAIngresar,
          tipo: TipoTransaccion.ingreso,
          fecha: fecha,
          idIngreso: Value(ingresoId),
        ));

        final updatedCuenta = cuenta.copyWith(
          saldoActual: cuenta.saldoActual + cantidadAIngresar,
          ingresoAcumuladoMes: cuenta.ingresoAcumuladoMes + cantidadAIngresar,
        );
        await _db.cuentasDao.upsertCuenta(updatedCuenta.toCompanion(false));

        cantidadRestante -= cantidadAIngresar;
      }
    }
  }

  Future<bool> agregarGasto(double cantidad, String concepto, int idCategoria,
      int idCuentaOrigen, DateTime selectedDate) async {
    final fecha = selectedDate;
    final cuentas = await _db.cuentasDao.allCuentas;
    final indiceCuentaOrigen =
        cuentas.indexWhere((c) => c.id == idCuentaOrigen);

    if (indiceCuentaOrigen == -1) {
      Logger().e('Error: Cuenta de origen no encontrada.');
      return false;
    }

    double saldoTotalDisponible = 0;
    for (int i = indiceCuentaOrigen; i < cuentas.length; i++) {
      saldoTotalDisponible += cuentas[i].saldoActual;
    }

    if (saldoTotalDisponible < cantidad) {
      Logger().w('Saldo insuficiente para agregar el gasto.');
      return false; // Not enough balance in all subsequent accounts
    }

    final gastoId = await _db.gastosDao.insertGasto(GastosCompanion.insert(
      cantidad: cantidad,
      concepto: concepto,
      fecha: fecha,
      idCategoria: idCategoria,
    ));

    var cantidadRestante = cantidad;

    for (int i = indiceCuentaOrigen; i < cuentas.length; i++) {
      if (cantidadRestante <= 0) break;

      final cuenta = cuentas[i];

      if (cuenta.saldoActual > 0) {
        final cantidadADebitar = cantidadRestante < cuenta.saldoActual
            ? cantidadRestante
            : cuenta.saldoActual;

        await _db.transaccionesDao
            .insertTransaccion(TransaccionesCompanion.insert(
          idCuenta: cuenta.id,
          cantidad: -cantidadADebitar, // Gasto es negativo
          tipo: TipoTransaccion.gasto,
          fecha: fecha,
          idGasto: Value(gastoId),
        ));

        final now = DateTime.now();
        final gastoAcumulado =
            (fecha.month == now.month && fecha.year == now.year)
                ? cuenta.gastoAcumuladoMes + cantidadADebitar
                : cuenta.gastoAcumuladoMes;

        final updatedCuenta = cuenta.copyWith(
          saldoActual: cuenta.saldoActual - cantidadADebitar,
          gastoAcumuladoMes: gastoAcumulado,
        );
        await _db.cuentasDao.upsertCuenta(updatedCuenta.toCompanion(false));

        cantidadRestante -= cantidadADebitar;
      }
    }
    return true;
  }

  Future<void> agregarGastoProgramado(
      double cantidad,
      String concepto,
      int idCategoria,
      int idCuentaOrigen,
      DateTime fechaInicio,
      Frecuencia frecuencia,
      DateTime? fechaFin,
      {int? diaDelMes,
      int? diaDeLaSemana,
      int? id}) async {
    await _db.transaccionesProgramadasDao.upsertTransaccionProgramada(
      TransaccionesProgramadasCompanion.insert(
        id: id != null ? Value(id) : const Value.absent(),
        descripcion: concepto,
        cantidad: cantidad,
        tipo: TipoTransaccion.gasto,
        idCategoria: Value(idCategoria),
        idCuentaOrigen: Value(idCuentaOrigen),
        frecuencia: frecuencia,
        fechaInicio: fechaInicio,
        proximaEjecucion: fechaInicio,
        fechaFin: Value(fechaFin),
        isTransferencia: const Value(false),
        diaDelMes: Value(diaDelMes),
        diaDeLaSemana: Value(diaDeLaSemana),
      ),
    );
  }

  Future<void> agregarIngresoProgramado(
      double cantidad,
      String concepto,
      int idCategoria,
      int idCuentaDestino,
      DateTime fechaInicio,
      Frecuencia frecuencia,
      DateTime? fechaFin,
      {int? diaDelMes,
      int? diaDeLaSemana,
      int? id}) async {
    await _db.transaccionesProgramadasDao.upsertTransaccionProgramada(
      TransaccionesProgramadasCompanion.insert(
        id: id != null ? Value(id) : const Value.absent(),
        descripcion: concepto,
        cantidad: cantidad,
        tipo: TipoTransaccion.ingreso,
        idCategoria: Value(idCategoria),
        idCuentaDestino: Value(idCuentaDestino),
        frecuencia: frecuencia,
        fechaInicio: fechaInicio,
        proximaEjecucion: fechaInicio,
        fechaFin: Value(fechaFin),
        isTransferencia: const Value(false),
        diaDelMes: Value(diaDelMes),
        diaDeLaSemana: Value(diaDeLaSemana),
      ),
    );
  }

  Future<void> agregarTransferenciaProgramada(
      double cantidad,
      String concepto,
      int idCuentaOrigen,
      int idCuentaDestino,
      DateTime fechaInicio,
      Frecuencia frecuencia,
      DateTime? fechaFin,
      {int? diaDelMes,
      int? diaDeLaSemana,
      int? id}) async {
    await _db.transaccionesProgramadasDao.upsertTransaccionProgramada(
      TransaccionesProgramadasCompanion.insert(
        id: id != null ? Value(id) : const Value.absent(),
        descripcion: concepto,
        cantidad: cantidad,
        tipo: TipoTransaccion.transferencia,
        idCuentaOrigen: Value(idCuentaOrigen),
        idCuentaDestino: Value(idCuentaDestino),
        frecuencia: frecuencia,
        fechaInicio: fechaInicio,
        proximaEjecucion: fechaInicio,
        fechaFin: Value(fechaFin),
        isTransferencia: const Value(true),
        diaDelMes: Value(diaDelMes),
        diaDeLaSemana: Value(diaDeLaSemana),
      ),
    );
  }

  Future<void> recalculateMonthlyAccumulated() async {
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);

    final allCuentas = await _db.cuentasDao.allCuentas;
    for (final cuenta in allCuentas) {
      double totalGastoMes = 0;
      double totalIngresoMes = 0;

      final transacciones = await (_db.transaccionesDao.select(_db.transacciones)
            ..where((tbl) => tbl.idCuenta.equals(cuenta.id) & tbl.fecha.isBiggerOrEqualValue(firstDayOfMonth)))
          .get();

      for (final tx in transacciones) {
        if (tx.tipo == TipoTransaccion.gasto) {
          totalGastoMes += tx.cantidad.abs();
        } else if (tx.tipo == TipoTransaccion.ingreso) {
          totalIngresoMes += tx.cantidad;
        }
      }

      final updatedCuenta = cuenta.copyWith(
        gastoAcumuladoMes: totalGastoMes,
        ingresoAcumuladoMes: totalIngresoMes,
      );
      await _db.cuentasDao.upsertCuenta(updatedCuenta.toCompanion(false));
    }
  }

  Future<void> handleMonthlyReset() async {
    try {
      final appSettings = await _db.appSettingsDao.getSettings();
      final now = DateTime.now();

      final lastReset = appSettings.lastResetDate;

      if (lastReset == null ||
          (lastReset.month != now.month || lastReset.year != now.year)) {
        final cuentas = await _db.cuentasDao.allCuentas;
        for (final cuenta in cuentas) {
          final updatedCuenta = cuenta.copyWith(
            sobranteMesAnterior: cuenta.saldoActual,
            gastoAcumuladoMes: 0.0,
            ingresoAcumuladoMes: 0.0,
          );
          await _db.cuentasDao.upsertCuenta(updatedCuenta.toCompanion(false));
        }

        // Update the last reset date
        await _db.appSettingsDao.updateSettings(
          AppSettingsCompanion(lastResetDate: Value(now)),
        );
      }
    } on SqliteException catch (e) {
      if (e.message.contains('no such column: last_reset_date')) {
        Logger()
            .w('Migration for last_reset_date pending. Skipping monthly reset.');
      } else {
        rethrow;
      }
    }
  }

  Future<void> checkAndExecuteScheduledIncomes() async {
    Logger().d('Checking and executing scheduled incomes...');
    final now = DateTime.now();
    final scheduledTransactions =
        await _db.transaccionesProgramadasDao.allTransaccionesProgramadas;

    for (final transaction in scheduledTransactions) {
      if (transaction.tipo == TipoTransaccion.ingreso &&
          (transaction.proximaEjecucion.isBefore(now) ||
              transaction.proximaEjecucion.isAtSameMomentAs(now))) {
        if (transaction.idCategoria != null &&
            transaction.idCuentaDestino != null) {
          await agregarIngreso(
            transaction.cantidad,
            transaction.idCategoria!,
            transaction.idCuentaDestino!,
            transaction.proximaEjecucion,
          );
        }

        // Calculate next execution date
        DateTime nextExecutionDate = transaction.proximaEjecucion;
        switch (transaction.frecuencia) {
          case Frecuencia.diaria:
            nextExecutionDate = DateTime(nextExecutionDate.year,
                nextExecutionDate.month, nextExecutionDate.day + 1);
            break;
          case Frecuencia.semanal:
            nextExecutionDate = DateTime(nextExecutionDate.year,
                nextExecutionDate.month, nextExecutionDate.day + 7);
            break;
          case Frecuencia.mensual:
            nextExecutionDate = DateTime(nextExecutionDate.year,
                nextExecutionDate.month + 1, nextExecutionDate.day);
            break;
          case Frecuencia.anual:
            nextExecutionDate = DateTime(nextExecutionDate.year + 1,
                nextExecutionDate.month, nextExecutionDate.day);
            break;
        }

        // Update the scheduled transaction
        await _db.transaccionesProgramadasDao.upsertTransaccionProgramada(
          transaction
              .copyWith(
                proximaEjecucion: nextExecutionDate,
              )
              .toCompanion(false),
        );
      }
    }
  }

  Future<void> checkAndExecuteScheduledExpenses() async {
    Logger().d('Checking and executing scheduled expenses...');
    final now = DateTime.now();
    final scheduledTransactions =
        await _db.transaccionesProgramadasDao.allTransaccionesProgramadas;

    for (final transaction in scheduledTransactions) {
      if (transaction.tipo == TipoTransaccion.gasto &&
          (transaction.proximaEjecucion.isBefore(now) ||
              transaction.proximaEjecucion.isAtSameMomentAs(now))) {
        if (transaction.idCategoria != null &&
            transaction.idCuentaOrigen != null) {
          await agregarGasto(
            transaction.cantidad,
            transaction.descripcion,
            transaction.idCategoria!,
            transaction.idCuentaOrigen!,
            transaction.proximaEjecucion,
          );
        }

        // Calculate next execution date
        DateTime nextExecutionDate = transaction.proximaEjecucion;
        switch (transaction.frecuencia) {
          case Frecuencia.diaria:
            nextExecutionDate = DateTime(nextExecutionDate.year,
                nextExecutionDate.month, nextExecutionDate.day + 1);
            break;
          case Frecuencia.semanal:
            nextExecutionDate = DateTime(nextExecutionDate.year,
                nextExecutionDate.month, nextExecutionDate.day + 7);
            break;
          case Frecuencia.mensual:
            nextExecutionDate = DateTime(nextExecutionDate.year,
                nextExecutionDate.month + 1, nextExecutionDate.day);
            break;
          case Frecuencia.anual:
            nextExecutionDate = DateTime(nextExecutionDate.year + 1,
                nextExecutionDate.month, nextExecutionDate.day);
            break;
        }

        // Update the scheduled transaction
        await _db.transaccionesProgramadasDao.upsertTransaccionProgramada(
          transaction
              .copyWith(
                proximaEjecucion: nextExecutionDate,
              )
              .toCompanion(false),
        );
      }
    }
  }

  Future<void> checkAndExecuteScheduledTransfers() async {
    Logger().d('Checking and executing scheduled transfers...');
    final now = DateTime.now();
    final scheduledTransactions =
        await _db.transaccionesProgramadasDao.allTransaccionesProgramadas;

    for (final transaction in scheduledTransactions) {
      if (transaction.isTransferencia &&
          (transaction.proximaEjecucion.isBefore(now) ||
              transaction.proximaEjecucion.isAtSameMomentAs(now))) {
        if (transaction.idCuentaOrigen != null &&
            transaction.idCuentaDestino != null) {
          await agregarTransferencia(
            transaction.cantidad,
            transaction.idCuentaOrigen!,
            transaction.idCuentaDestino!,
            transaction.proximaEjecucion,
            concepto: transaction.descripcion,
          );
        }

        // Calculate next execution date
        DateTime nextExecutionDate = transaction.proximaEjecucion;
        switch (transaction.frecuencia) {
          case Frecuencia.diaria:
            nextExecutionDate = DateTime(nextExecutionDate.year,
                nextExecutionDate.month, nextExecutionDate.day + 1);
            break;
          case Frecuencia.semanal:
            nextExecutionDate = DateTime(nextExecutionDate.year,
                nextExecutionDate.month, nextExecutionDate.day + 7);
            break;
          case Frecuencia.mensual:
            nextExecutionDate = DateTime(nextExecutionDate.year,
                nextExecutionDate.month + 1, nextExecutionDate.day);
            break;
          case Frecuencia.anual:
            nextExecutionDate = DateTime(nextExecutionDate.year + 1,
                nextExecutionDate.month, nextExecutionDate.day);
            break;
        }

        // Update the scheduled transaction
        await _db.transaccionesProgramadasDao.upsertTransaccionProgramada(
          transaction
              .copyWith(
                proximaEjecucion: nextExecutionDate,
              )
              .toCompanion(false),
        );
      }
    }
  }

  Future<void> initializeDatabase() async {
    // La lógica de inicialización ahora está en SetupScreen
  }

  Future<void> createAccount(
      String nombre, double saldoMaximo, double limiteGasto) async {
    await _db.cuentasDao.upsertCuenta(CuentasCompanion.insert(
        nombre: nombre,
        saldoActual: 0,
        saldoMaximoMensual: saldoMaximo,
        limiteGastoMensual: limiteGasto));
  }

  Future<void> createDefaultCategories() async {
    final categorias = await _db.categoriasDao.allCategorias;
    if (categorias.isEmpty) {
      await _db.batch((batch) {
        batch.insertAll(_db.categorias, defaultIncomeCategories);
        batch.insertAll(_db.categorias, defaultExpenseCategories);
      });
    }
  }

  Future<String> exportTransactionsToCsv() async {
    final transacciones = await _db.transaccionesDao.allTransacciones;
    final cuentas = await _db.cuentasDao.allCuentas;
    final gastos = await _db.gastosDao.allGastos;
    final ingresos = await _db.ingresosDao.allIngresos;
    final categorias = await _db.categoriasDao.allCategorias;

    final List<List<dynamic>> rows = [];
    rows.add(
        ['ID', 'Fecha', 'Cuenta', 'Tipo', 'Cantidad', 'Concepto', 'Categoria']);

    for (final t in transacciones) {
      final cuenta = cuentas.firstWhere((c) => c.id == t.idCuenta);
      String concepto = '';
      String categoria = '';

      if (t.idGasto != null) {
        final gasto = gastos.firstWhere((g) => g.id == t.idGasto);
        concepto = gasto.concepto;
        categoria =
            categorias.firstWhere((c) => c.id == gasto.idCategoria).nombre;
      } else if (t.idIngreso != null) {
        final ingreso = ingresos.firstWhere((i) => i.id == t.idIngreso);
        categoria =
            categorias.firstWhere((c) => c.id == ingreso.idCategoria).nombre;
      }
      rows.add([
        t.id,
        t.fecha.toIso8601String(),
        cuenta.nombre,
        t.tipo.toString(),
        t.cantidad,
        concepto,
        categoria,
      ]);
    }

    return const ListToCsvConverter().convert(rows);
  }

  Future<double> calculatePreviousMonthSavings() async {
    final now = DateTime.now();
    final firstDayOfCurrentMonth = DateTime(now.year, now.month, 1);
    final lastDayOfPreviousMonth =
        firstDayOfCurrentMonth.subtract(const Duration(days: 1));
    final firstDayOfPreviousMonth = DateTime(
        lastDayOfPreviousMonth.year, lastDayOfPreviousMonth.month, 1);

    final transactions = await (_db.transaccionesDao.select(_db.transacciones)
          ..where((tbl) => tbl.fecha.isBetween(
              Variable(firstDayOfPreviousMonth), Variable(lastDayOfPreviousMonth))))
        .get();

    double totalIncome = 0;
    double totalExpenses = 0;

    for (final tx in transactions) {
      if (tx.tipo == TipoTransaccion.ingreso) {
        totalIncome += tx.cantidad;
      } else if (tx.tipo == TipoTransaccion.gasto) {
        totalExpenses += tx.cantidad.abs();
      }
    }

    return totalIncome - totalExpenses;
  }

  Future<bool> agregarTransferencia(
      double cantidad,
      int idCuentaOrigen,
      int idCuentaDestino,
      DateTime selectedDate,
      {String? concepto}) async {
    // Get or create expense category
    var categoriaGasto = await _db.categoriasDao
        .getCategoryByNameAndType('Traspaso', TipoCategoria.gasto.index);
    if (categoriaGasto == null) {
      await _db.categoriasDao.upsertCategoria(
        CategoriasCompanion.insert(
          nombre: 'Traspaso',
          tipo: TipoCategoria.gasto,
          color: '#808080', // Grey color
        ),
      );
      categoriaGasto = await _db.categoriasDao
          .getCategoryByNameAndType('Traspaso', TipoCategoria.gasto.index);
    }

    // Get or create income category
    var categoriaIngreso = await _db.categoriasDao
        .getCategoryByNameAndType('Traspaso', TipoCategoria.ingreso.index);
    if (categoriaIngreso == null) {
      await _db.categoriasDao.upsertCategoria(
        CategoriasCompanion.insert(
          nombre: 'Traspaso',
          tipo: TipoCategoria.ingreso,
          color: '#808080', // Grey color
        ),
      );
      categoriaIngreso = await _db.categoriasDao
          .getCategoryByNameAndType('Traspaso', TipoCategoria.ingreso.index);
    }

    if (categoriaGasto == null || categoriaIngreso == null) {
      Logger().e('No se pudo obtener o crear la categoría "Traspaso".');
      return false;
    }

    final gastoSuccess = await agregarGasto(
      cantidad,
      concepto ?? 'Traspaso',
      categoriaGasto.id,
      idCuentaOrigen,
      selectedDate,
    );

    if (gastoSuccess) {
      await agregarIngreso(
        cantidad,
        categoriaIngreso.id,
        idCuentaDestino,
        selectedDate,
      );
    }

    return gastoSuccess;
  }

}