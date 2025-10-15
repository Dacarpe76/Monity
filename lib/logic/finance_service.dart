import 'dart:math';
import 'package:drift/drift.dart';
import 'package:monity/data/database.dart';
import 'package:csv/csv.dart';
import 'package:logger/logger.dart';

class FinanceService {
  final AppDatabase _db;

  FinanceService(this._db);

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
      final isPaymentDue =
          credit.paymentDay == now.day && credit.remainingAmount > 0;
      final alreadyPaidThisMonth = credit.lastPaymentDate != null &&
          credit.lastPaymentDate!.year == now.year &&
          credit.lastPaymentDate!.month == now.month;

      if (isPaymentDue && !alreadyPaidThisMonth) {
        Logger().i('Processing payment for credit: ${credit.name}');
        await _db.transaction(() async {
          final cuenta =
              await _db.cuentasDao.getCuentaById(credit.linkedAccountId);
          if (cuenta == null) {
            Logger().e('Linked account for credit ${credit.name} not found.');
            return;
          }

          final paymentAmount = (credit.paymentAmount < credit.remainingAmount)
              ? credit.paymentAmount
              : credit.remainingAmount;

          final gastoId =
              await _db.gastosDao.insertGasto(GastosCompanion.insert(
            cantidad: paymentAmount,
            concepto: 'Pago crédito: ${credit.name}',
            fecha: now,
            idCategoria: categoriaPrestamos.id,
          ));

          await _db.transaccionesDao
              .insertTransaccion(TransaccionesCompanion.insert(
            idCuenta: credit.linkedAccountId,
            cantidad: -paymentAmount,
            tipo: TipoTransaccion.gasto,
            fecha: now,
            idGasto: Value(gastoId),
          ));

          final updatedCuenta = cuenta.copyWith(
            saldoActual: cuenta.saldoActual - paymentAmount,
            gastoAcumuladoMes: cuenta.gastoAcumuladoMes + paymentAmount,
          );
          await _db.cuentasDao.upsertCuenta(updatedCuenta.toCompanion(false));

          final updatedCredit = credit.copyWith(
            remainingAmount: credit.remainingAmount - paymentAmount,
            lastPaymentDate: Value(now),
          );
          await _db.creditosDao.upsertCredito(updatedCredit.toCompanion(false));
        });
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
          (cuenta.saldoMaximoMensual - cuenta.sobranteMesAnterior) -
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

  Future<void> agregarGasto(double cantidad, String concepto, int idCategoria,
      int idCuentaOrigen, DateTime selectedDate) async {
    final fecha = selectedDate;
    final gastoId = await _db.gastosDao.insertGasto(GastosCompanion.insert(
      cantidad: cantidad,
      concepto: concepto,
      fecha: fecha,
      idCategoria: idCategoria,
    ));

    final cuentas = await _db.cuentasDao.allCuentas;
    var cantidadRestante = cantidad;

    final indiceCuentaOrigen =
        cuentas.indexWhere((c) => c.id == idCuentaOrigen);
    if (indiceCuentaOrigen == -1) {
      Logger().e('Error: Cuenta de origen no encontrada.');
      return;
    }

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
    final hoy = DateTime.now();
    // Idealmente, guardar la fecha del último reinicio en la BD para no hacerlo varias veces.
    // Por simplicidad, lo haremos si es el primer día del mes.
    if (hoy.day == 1) {
      final cuentas = await _db.cuentasDao.allCuentas;
      for (final cuenta in cuentas) {
        final updatedCuenta = cuenta.copyWith(
          sobranteMesAnterior: cuenta.saldoActual,
          gastoAcumuladoMes: 0.0,
          ingresoAcumuladoMes: 0.0,
        );
        await _db.cuentasDao.upsertCuenta(updatedCuenta.toCompanion(false));
      }
    }
  }

  Future<void> checkAndExecuteScheduledTransactions() async {
    Logger().d('Checking and executing scheduled transactions...');
    final now = DateTime.now();
    final scheduledTransactions =
        await _db.transaccionesProgramadasDao.allTransaccionesProgramadas;

    for (final transaction in scheduledTransactions) {
      if (transaction.proximaEjecucion.isBefore(now) ||
          transaction.proximaEjecucion.isAtSameMomentAs(now)) {
        // Execute the transaction
        if (transaction.isTransferencia) {
          if (transaction.idCuentaOrigen != null &&
              transaction.idCuentaDestino != null) {
            await agregarTransferencia(
              transaction.cantidad,
              transaction.idCuentaOrigen!,
              transaction.idCuentaDestino!,
              transaction.proximaEjecucion,
            );
          }
        } else if (transaction.tipo == TipoTransaccion.ingreso) {
          if (transaction.idCategoria != null &&
              transaction.idCuentaDestino != null) {
            await agregarIngreso(
              transaction.cantidad,
              transaction.idCategoria!,
              transaction.idCuentaDestino!,
              transaction.proximaEjecucion,
            );
          }
        } else if (transaction.tipo == TipoTransaccion.gasto) {
          if (transaction.idCategoria != null &&
              transaction.idCuentaOrigen != null) {
            await agregarGasto(
              transaction.cantidad,
              transaction
                  .descripcion, // Using description as concept for scheduled expenses
              transaction.idCategoria!,
              transaction.idCuentaOrigen!,
              transaction.proximaEjecucion,
            );
          }
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
    final cuentas = await _db.cuentasDao.allCuentas;
    if (cuentas.isEmpty) {
      // Valores iniciales por defecto
      await _db.cuentasDao.upsertCuenta(CuentasCompanion.insert(
          nombre: 'Bolsillo',
          saldoActual: 0,
          saldoMaximoMensual: 300,
          limiteGastoMensual: 200));
      await _db.cuentasDao.upsertCuenta(CuentasCompanion.insert(
          nombre: 'Diario',
          saldoActual: 0,
          saldoMaximoMensual: 800,
          limiteGastoMensual: 700));
      await _db.cuentasDao.upsertCuenta(CuentasCompanion.insert(
          nombre: 'Imprevistos',
          saldoActual: 0,
          saldoMaximoMensual: 3600,
          limiteGastoMensual: 1000));
      await _db.cuentasDao.upsertCuenta(CuentasCompanion.insert(
          nombre: 'Emergencias',
          saldoActual: 0,
          saldoMaximoMensual: 10000,
          limiteGastoMensual: 2000));
      await _db.cuentasDao.upsertCuenta(CuentasCompanion.insert(
          nombre: 'Ahorro',
          saldoActual: 0,
          saldoMaximoMensual: 10000000,
          limiteGastoMensual: 10000));
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

  Future<void> agregarTransferencia(double cantidad, int idCuentaOrigen,
      int idCuentaDestino, DateTime selectedDate) async {
    final fecha = selectedDate;

    final cuentaOrigen = await _db.cuentasDao.getCuentaById(idCuentaOrigen);
    final cuentaDestino = await _db.cuentasDao.getCuentaById(idCuentaDestino);

    if (cuentaOrigen == null || cuentaDestino == null) {
      Logger().e('Error: Cuenta de origen o destino no encontrada.');
      return;
    }

    // Debitar de la cuenta de origen
    await _db.transaccionesDao.insertTransaccion(TransaccionesCompanion.insert(
      idCuenta: idCuentaOrigen,
      cantidad: -cantidad, // Negativo porque es un débito
      tipo: TipoTransaccion.transferencia,
      fecha: fecha,
    ));

    final updatedCuentaOrigen =
        cuentaOrigen.copyWith(saldoActual: cuentaOrigen.saldoActual - cantidad);
    await _db.cuentasDao.upsertCuenta(updatedCuentaOrigen.toCompanion(false));

    // Acreditar a la cuenta de destino
    await _db.transaccionesDao.insertTransaccion(TransaccionesCompanion.insert(
      idCuenta: idCuentaDestino,
      cantidad: cantidad, // Positivo porque es un crédito
      tipo: TipoTransaccion.transferencia,
      fecha: fecha,
    ));

    final updatedCuentaDestino = cuentaDestino.copyWith(
        saldoActual: cuentaDestino.saldoActual + cantidad);
    await _db.cuentasDao.upsertCuenta(updatedCuentaDestino.toCompanion(false));
  }
}
