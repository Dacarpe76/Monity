import 'package:drift/drift.dart';
import 'package:flutter/services.dart';
import 'dart:math';

import 'package:monity/data/default_categories.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Conditional import for the platform-specific connection implementation
import 'package:monity/data/connection/connection.stub.dart'
    if (dart.library.io) 'package:monity/data/connection/connection_io.dart'
    if (dart.library.html) 'package:monity/data/connection/connection_web.dart';

part 'database.g.dart';

// --- ENUMS ---

enum TipoCategoria { ingreso, gasto }

enum TipoTransaccion { ingreso, gasto, transferencia }

enum Frecuencia { diaria, semanal, mensual, anual }

enum CreditType { fijo, variable }

// --- TABLAS ---

@DataClassName('Credito')
class Creditos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 1, max: 50)();
  IntColumn get creditType => intEnum<CreditType>()();
  RealColumn get totalAmount => real()();
  RealColumn get remainingAmount => real()();
  RealColumn get paymentAmount => real()();
  RealColumn get interestRate => real()();
  IntColumn get paymentDay => integer()();
  IntColumn get linkedAccountId => integer().references(Cuentas, #id)();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastPaymentDate => dateTime().nullable()();
  IntColumn get plazoEnMeses => integer().withDefault(const Constant(0))();
  RealColumn get comisionAmortizacionParcial => real().nullable()();
  RealColumn get comisionCancelacionTotal => real().nullable()();
}

@DataClassName('Cuenta')
class Cuentas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 50)();
  RealColumn get saldoActual => real()();
  RealColumn get saldoMaximoMensual => real()();
  RealColumn get limiteGastoMensual => real()();
  RealColumn get gastoAcumuladoMes => real().withDefault(const Constant(0.0))();
  RealColumn get ingresoAcumuladoMes =>
      real().withDefault(const Constant(0.0))();
  RealColumn get sobranteMesAnterior =>
      real().withDefault(const Constant(0.0))();
  IntColumn get orden => integer().withDefault(const Constant(999))();
  RealColumn get adjustmentPercentage =>
      real().withDefault(const Constant(0.90))();
  RealColumn get maxBalancePercentage =>
      real().withDefault(const Constant(1.20))();
}

@DataClassName('Categoria')
class Categorias extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 50)();
  IntColumn get tipo => intEnum<TipoCategoria>()();
  TextColumn get color => text()();
  TextColumn get icono => text().withDefault(const Constant(''))();

  @override
  List<String> get customConstraints => [
        'UNIQUE(nombre, tipo)',
      ];
}

@DataClassName('Ingreso')
class Ingresos extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get cantidadTotal => real()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get idCategoria => integer().references(Categorias, #id)();
}

@DataClassName('Gasto')
class Gastos extends Table {
  IntColumn get id => integer().autoIncrement()();
  RealColumn get cantidad => real()();
  TextColumn get concepto => text().withLength(min: 1, max: 100)();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get idCategoria => integer().references(Categorias, #id)();
}

@DataClassName('Transaccion')
class Transacciones extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get idCuenta => integer().references(Cuentas, #id)();
  RealColumn get cantidad => real()();
  IntColumn get tipo => intEnum<TipoTransaccion>()();
  DateTimeColumn get fecha => dateTime()();
  IntColumn get idGasto => integer().nullable().references(Gastos, #id)();
  IntColumn get idIngreso => integer().nullable().references(Ingresos, #id)();
}

@DataClassName('TransaccionProgramada')
class TransaccionesProgramadas extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get descripcion => text().withLength(min: 1, max: 100)();
  RealColumn get cantidad => real()();
  IntColumn get tipo => intEnum<TipoTransaccion>()();
  IntColumn get idCategoria =>
      integer().nullable().references(Categorias, #id)();
  @ReferenceName('TransaccionesProgramadasComoOrigen')
  IntColumn get idCuentaOrigen =>
      integer().nullable().references(Cuentas, #id)();
  @ReferenceName('TransaccionesProgramadasComoDestino')
  IntColumn get idCuentaDestino =>
      integer().nullable().references(Cuentas, #id)();
  IntColumn get frecuencia => intEnum<Frecuencia>()();
  DateTimeColumn get fechaInicio => dateTime()();
  DateTimeColumn get proximaEjecucion => dateTime()();
  DateTimeColumn get fechaFin => dateTime().nullable()();
  BoolColumn get isTransferencia =>
      boolean().withDefault(const Constant(false))();
  IntColumn get diaDelMes => integer().nullable()();
  IntColumn get diaDeLaSemana => integer().nullable()();
}

class DetailedTransaction {
  final Transaccion transaccion;
  final Gasto? gasto;
  final Categoria? categoria;

  DetailedTransaction({
    required this.transaccion,
    this.gasto,
    this.categoria,
  });
}

class CategoriaWithUsage {
  final Categoria categoria;
  final int usageCount;

  CategoriaWithUsage({required this.categoria, required this.usageCount});
}

@DataClassName('AppSetting')
class AppSettings extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get currency => text().withDefault(const Constant('EUR'))();
  BoolColumn get showBudgetLimit =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get showMaxBalance =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get showMonthlySpending =>
      boolean().withDefault(const Constant(true))();
  BoolColumn get showProjection =>
      boolean().withDefault(const Constant(true))();
  DateTimeColumn get lastResetDate => dateTime().nullable()();
  BoolColumn get monityControlEnabled =>
      boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('Quote')
class Quotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get quoteText => text()();
  BoolColumn get isUsed => boolean().withDefault(const Constant(false))();
}

// --- DATABASE CLASS ---

@DataClassName('Premio')
class Premios extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text().withLength(min: 1, max: 50)();
  RealColumn get importe => real()();
  RealColumn get acumulado => real().withDefault(const Constant(0.0))();
  TextColumn get fotoPath => text()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
}

@DataClassName('HistorialSaldo')
class HistorialSaldos extends Table {
  IntColumn get id => integer().autoIncrement()();
  DateTimeColumn get fecha => dateTime()();
  RealColumn get saldo => real()();
}

@DriftDatabase(tables: [
  Cuentas,
  Categorias,
  Ingresos,
  Gastos,
  Transacciones,
  TransaccionesProgramadas,
  Creditos,
  AppSettings,
  Quotes,
  HistorialSaldos,
  Premios,
], daos: [
  CuentasDao,
  CategoriasDao,
  IngresosDao,
  GastosDao,
  TransaccionesDao,
  TransaccionesProgramadasDao,
  CreditosDao,
  AppSettingsDao,
  QuotesDao,
  HistorialSaldosDao,
  PremiosDao,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(connect());

  @override
  int get schemaVersion => 23;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          await batch((batch) {
            batch.insertAll(categorias, defaultIncomeCategories);
            batch.insertAll(categorias, defaultExpenseCategories);
          });
          await into(appSettings).insert(AppSettingsCompanion());

          // Cargar y añadir las frases motivadoras
          final content = await rootBundle.loadString('assets/frases.txt');
          final allQuotes = content
              .split(RegExp(r'\r\n\r\n|\n\n'))
              .where((q) => q.trim().isNotEmpty)
              .toList();
          final quotesCompanions = allQuotes
              .map((q) => QuotesCompanion.insert(quoteText: q.trim()))
              .toList();
          await batch((batch) {
            batch.insertAll(quotes, quotesCompanions);
          });
        },
        onUpgrade: (m, from, to) async {
          // print('Running migration from $from to $to');
          if (from < 2) {
            // No migration logic from v1 to v2 was provided before.
          }
          if (from < 3) {
            await m.addColumn(categorias, categorias.tipo);
            await m.addColumn(categorias, categorias.color);

            await m.addColumn(ingresos, ingresos.idCategoria);
          }
          if (from < 4) {
            await m.createTable(transaccionesProgramadas);
          }
          if (from < 5) {
            // Insert default categories if they don't exist
            for (final category in defaultIncomeCategories) {
              final existingCategory =
                  await categoriasDao.getCategoryByNameAndType(
                      category.nombre.value, category.tipo.value.index);
              if (existingCategory == null) {
                await categoriasDao.upsertCategoria(category);
              }
            }
            for (final category in defaultExpenseCategories) {
              final existingCategory =
                  await categoriasDao.getCategoryByNameAndType(
                      category.nombre.value, category.tipo.value.index);
              if (existingCategory == null) {
                await categoriasDao.upsertCategoria(category);
              }
            }
          }
          if (from < 6) {
            // Añadir la columna orden a la tabla cuentas
            await m.addColumn(cuentas, cuentas.orden);

            // Inicializar el orden de las cuentas existentes
            final allAccounts =
                await customSelect('SELECT id FROM cuentas').get();
            for (var i = 0; i < allAccounts.length; i++) {
              await customUpdate(
                'UPDATE cuentas SET orden = ? WHERE id = ?',
                variables: [
                  Variable.withInt(i),
                  Variable.withInt(allAccounts[i].data['id'] as int)
                ],
                updates: {cuentas},
              );
            }
          }

          if (from < 9) {
            await m.createTable(creditos);
          }
          if (from < 10) {
            await m.addColumn(creditos, creditos.lastPaymentDate);
          }
          if (from < 11) {
            await m.addColumn(creditos, creditos.plazoEnMeses);
            await m.addColumn(creditos, creditos.comisionAmortizacionParcial);
            await m.addColumn(creditos, creditos.comisionCancelacionTotal);
          }
          if (from < 12) {
            await m.createTable(appSettings);
            await into(appSettings).insert(AppSettingsCompanion());
          }
          if (from < 13) {
            await m.addColumn(appSettings, appSettings.showMaxBalance);
          }
          if (from < 14) {
            await customUpdate(
              'UPDATE app_settings SET show_max_balance = ? WHERE show_max_balance IS NULL',
              variables: [Variable.withBool(true)],
              updates: {appSettings},
            );
          }
          if (from < 15) {
            await m.addColumn(transaccionesProgramadas, transaccionesProgramadas.diaDelMes);
            await m.addColumn(transaccionesProgramadas, transaccionesProgramadas.diaDeLaSemana);
          }
          if (from < 16) {
            await m.addColumn(appSettings, appSettings.currency);
          }
          if (from < 17) {
            await m.createTable(quotes);
          }
          if (from < 18) {
            await m.addColumn(cuentas, cuentas.adjustmentPercentage);
            await m.addColumn(cuentas, cuentas.maxBalancePercentage);
          }
          if (from < 19) {
            // Cargar y añadir las frases motivadoras si la tabla está vacía
            final count = await customSelect('SELECT COUNT(*) as c FROM quotes')
                .getSingle();
            if (count.read<int>('c') == 0) {
              final content = await rootBundle.loadString('assets/frases.txt');
              final allQuotes = content
                  .split(RegExp(r'\r\n\r\n|\n\n'))
                  .where((q) => q.trim().isNotEmpty)
                  .toList();
              final quotesCompanions = allQuotes
                  .map((q) => QuotesCompanion.insert(quoteText: q.trim()))
                  .toList();
              await batch((batch) {
                batch.insertAll(quotes, quotesCompanions);
              });
            }
          }
          if (from < 20) {
            await m.addColumn(appSettings, appSettings.lastResetDate);
          }
          if (from < 21) {
            await m.createTable(historialSaldos);
          }
          if (from < 22) {
            final cuentasList = await customSelect('SELECT id, adjustment_percentage, max_balance_percentage FROM cuentas').get();
            for (final cuenta in cuentasList) {
              final id = cuenta.read<int>('id');
              final adjustment = cuenta.read<double>('adjustment_percentage');
              final maxBalance = cuenta.read<double>('max_balance_percentage');
              await customUpdate(
                'UPDATE cuentas SET adjustment_percentage = ?, max_balance_percentage = ? WHERE id = ?',
                variables: [
                  Variable.withReal(maxBalance),
                  Variable.withReal(adjustment),
                  Variable.withInt(id),
                ],
                updates: {cuentas},
              );
            }
          }
          if (from < 23) {
            await m.createTable(premios);
          }
        },
      );

  Future<void> resetDatabase() {
    return transaction(() async {
      // 1. Eliminar datos de transacciones, pero no las cuentas
      await delete(transacciones).go();
      await delete(transaccionesProgramadas).go();
      await delete(gastos).go();
      await delete(ingresos).go();
      await delete(creditos).go();

      // 2. Actualizar las cuentas a 0, manteniendo los límites y la existencia de las cuentas
      await update(cuentas).write(
        const CuentasCompanion(
          saldoActual: Value(0.0),
          gastoAcumuladoMes: Value(0.0),
          ingresoAcumuladoMes: Value(0.0),
          sobranteMesAnterior: Value(0.0),
        ),
      );
    });
  }
}

// --- DAOs ---

@DriftAccessor(tables: [Premios])
class PremiosDao extends DatabaseAccessor<AppDatabase> with _$PremiosDaoMixin {
  PremiosDao(super.db);

  Future<void> upsertPremio(PremiosCompanion premio) =>
      into(premios).insertOnConflictUpdate(premio);
  Stream<Premio?> watchActivePremio() =>
      (select(premios)..where((p) => p.isCompleted.equals(false))).watchSingleOrNull();
  Future<Premio?> getActivePremio() =>
      (select(premios)..where((p) => p.isCompleted.equals(false))).getSingleOrNull();
}

@DriftAccessor(tables: [Creditos])
class CreditosDao extends DatabaseAccessor<AppDatabase>
    with _$CreditosDaoMixin {
  CreditosDao(super.db);

  Future<List<Credito>> get allCreditos => select(creditos).get();
  Stream<List<Credito>> watchAllCreditos() => (select(creditos)
        ..where((c) => c.remainingAmount.isBiggerThan(const Constant(0.0))))
      .watch();
  Stream<List<Credito>> watchCreditsForAccount(int accountId) {
    return (select(creditos)..where((c) => c.linkedAccountId.equals(accountId)))
        .watch();
  }

  Future<void> upsertCredito(CreditosCompanion credito) =>
      into(creditos).insertOnConflictUpdate(credito);
  Future<void> deleteCredito(int id) =>
      (delete(creditos)..where((tbl) => tbl.id.equals(id))).go();
}

@DriftAccessor(tables: [Cuentas])
class CuentasDao extends DatabaseAccessor<AppDatabase> with _$CuentasDaoMixin {
  CuentasDao(super.db);

  // Modificar estos métodos para incluir el orden
  Future<List<Cuenta>> get allCuentas =>
      (select(cuentas)..orderBy([(t) => OrderingTerm(expression: t.orden)]))
          .get();
  Stream<List<Cuenta>> watchAllCuentas() =>
      (select(cuentas)..orderBy([(t) => OrderingTerm(expression: t.orden)]))
          .watch();

  // Métodos existentes
  Future<void> upsertCuenta(CuentasCompanion cuenta) =>
      into(cuentas).insertOnConflictUpdate(cuenta);
  Future<Cuenta?> getCuentaById(int id) =>
      (select(cuentas)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();

  // Método para eliminar una cuenta y todas sus transacciones asociadas
  Future<void> deleteCuenta(int id) async {
    await transaction(() async {
      // 1. Obtener todas las transacciones de la cuenta para recolectar los IDs a borrar
      final transaccionesToDelete = await (select(db.transacciones)
            ..where((t) => t.idCuenta.equals(id)))
          .get();

      final gastoIds =
          transaccionesToDelete.map((t) => t.idGasto).whereType<int>().toList();
      final ingresoIds = transaccionesToDelete
          .map((t) => t.idIngreso)
          .whereType<int>()
          .toList();

      // 2. Borrar gastos e ingresos asociados en lote (más eficiente)
      if (gastoIds.isNotEmpty) {
        await (delete(db.gastos)..where((g) => g.id.isIn(gastoIds))).go();
      }
      if (ingresoIds.isNotEmpty) {
        await (delete(db.ingresos)..where((i) => i.id.isIn(ingresoIds))).go();
      }

      // 3. Eliminar todas las transacciones de la cuenta
      await (delete(db.transacciones)..where((t) => t.idCuenta.equals(id)))
          .go();

      // 4. Eliminar las transacciones programadas asociadas a esta cuenta
      await (delete(db.transaccionesProgramadas)
            ..where((t) =>
                t.idCuentaOrigen.equals(id) | t.idCuentaDestino.equals(id)))
          .go();

      // 5. Delete linked credits
      await (delete(db.creditos)..where((c) => c.linkedAccountId.equals(id)))
          .go();

      // 6. Finalmente, eliminar la cuenta
      await (delete(cuentas)..where((c) => c.id.equals(id))).go();

      // 7. Reordenar las cuentas restantes
      final cuentasRestantes = await allCuentas;
      for (var i = 0; i < cuentasRestantes.length; i++) {
        await updateOrden(cuentasRestantes[i].id, i);
      }
    });
  }

  // Nuevo método para actualizar el orden
  Future<void> updateOrden(int cuentaId, int nuevoOrden) async {
    await (update(cuentas)..where((tbl) => tbl.id.equals(cuentaId)))
        .write(CuentasCompanion(orden: Value(nuevoOrden)));
  }
}

@DriftAccessor(tables: [Categorias])
class CategoriasDao extends DatabaseAccessor<AppDatabase>
    with _$CategoriasDaoMixin {
  CategoriasDao(super.db);

  Future<List<Categoria>> get allCategorias => select(categorias).get();
  Stream<List<Categoria>> watchAllCategorias() => select(categorias).watch();

  Stream<List<CategoriaWithUsage>> watchAllCategoriasSorted() {
    final usageCount = CustomExpression<int>(
        '(SELECT COUNT(*) FROM gastos WHERE gastos.id_categoria = categorias.id) + (SELECT COUNT(*) FROM ingresos WHERE ingresos.id_categoria = categorias.id)');

    final query = select(categorias).addColumns([usageCount]);

    query.orderBy([
      OrderingTerm(expression: usageCount, mode: OrderingMode.desc),
      OrderingTerm(expression: categorias.nombre, mode: OrderingMode.asc),
    ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return CategoriaWithUsage(
          categoria: row.readTable(categorias),
          usageCount: row.read(usageCount) ?? 0,
        );
      }).toList();
    });
  }

  Future<void> upsertCategoria(CategoriasCompanion categoria) =>
      into(categorias).insertOnConflictUpdate(categoria);
  Future<void> deleteCategoria(int id) =>
      (delete(categorias)..where((tbl) => tbl.id.equals(id))).go();
  Future<Categoria?> getCategoryByNameAndType(
          String name, int type) => // Changed TipoCategoria to int
      (select(categorias)
            ..where((tbl) => tbl.nombre.equals(name) & tbl.tipo.equals(type)))
          .getSingleOrNull();

  Future<Categoria?> getCategoryById(int id) =>
      (select(categorias)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
}

@DriftAccessor(tables: [Ingresos])
class IngresosDao extends DatabaseAccessor<AppDatabase>
    with _$IngresosDaoMixin {
  IngresosDao(super.db);

  Future<int> insertIngreso(IngresosCompanion ingreso) =>
      into(ingresos).insert(ingreso);
  Future<List<Ingreso>> get allIngresos => select(ingresos).get();
  Future<Ingreso?> getIngresoById(int id) =>
      (select(ingresos)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  Future<void> deleteIngreso(int id) =>
      (delete(ingresos)..where((tbl) => tbl.id.equals(id))).go();
}

@DriftAccessor(tables: [Gastos])
class GastosDao extends DatabaseAccessor<AppDatabase> with _$GastosDaoMixin {
  GastosDao(super.db);

  Future<int> insertGasto(GastosCompanion gasto) => into(gastos).insert(gasto);
  Future<List<Gasto>> get allGastos => select(gastos).get();
  Future<Gasto?> getGastoById(int id) =>
      (select(gastos)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  Future<void> deleteGasto(int id) =>
      (delete(gastos)..where((tbl) => tbl.id.equals(id))).go();
}

@DriftAccessor(tables: [Transacciones, Gastos, Categorias, Cuentas, Ingresos])
class TransaccionesDao extends DatabaseAccessor<AppDatabase>
    with _$TransaccionesDaoMixin {
  TransaccionesDao(super.db);

  Future<void> insertTransaccion(TransaccionesCompanion transaccion) =>
      into(transacciones).insert(transaccion);
  Stream<List<Transaccion>> watchTransaccionesForCuenta(int cuentaId) {
    return (select(transacciones)
          ..where((tbl) => tbl.idCuenta.equals(cuentaId)))
        .watch();
  }

  Stream<List<DetailedTransaction>> watchDetailedTransaccionesForCuenta(
      int cuentaId,
      [DateTime? date]) {
    final query = select(transacciones).join([
      leftOuterJoin(gastos, gastos.id.equalsExp(transacciones.idGasto)),
      leftOuterJoin(categorias, categorias.id.equalsExp(gastos.idCategoria)),
    ])
      ..where(transacciones.idCuenta.equals(cuentaId));

    if (date != null) {
      query.where(transacciones.fecha.year.equals(date.year));
      query.where(transacciones.fecha.month.equals(date.month));
    }

    return query.watch().map((rows) {
      return rows.map((row) {
        return DetailedTransaction(
          transaccion: row.readTable(transacciones),
          gasto: row.readTableOrNull(gastos),
          categoria: row.readTableOrNull(categorias),
        );
      }).toList();
    });
  }

  Stream<List<DetailedTransaction>> watchAllDetailedTransacciones(
      [DateTime? date]) {
    final query = select(transacciones).join([
      leftOuterJoin(gastos, gastos.id.equalsExp(transacciones.idGasto)),
      leftOuterJoin(categorias, categorias.id.equalsExp(gastos.idCategoria)),
    ]);

    if (date != null) {
      query.where(transacciones.fecha.year.equals(date.year));
      query.where(transacciones.fecha.month.equals(date.month));
    }

    return query.watch().map((rows) {
      return rows.map((row) {
        return DetailedTransaction(
          transaccion: row.readTable(transacciones),
          gasto: row.readTableOrNull(gastos),
          categoria: row.readTableOrNull(categorias),
        );
      }).toList();
    });
  }

  Stream<List<Transaccion>> watchAllTransacciones() =>
      select(transacciones).watch();
  Future<List<Transaccion>> get allTransacciones => select(transacciones).get();
  Future<Transaccion?> getTransaccionById(int id) =>
      (select(transacciones)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  Future<void> deleteTransaccion(int id) {
    return transaction(() async {
      final transactionToDelete = await (select(transacciones)
            ..where((tbl) => tbl.id.equals(id)))
          .getSingleOrNull();

      if (transactionToDelete == null) {
        return; // No transaction found with this id.
      }

      if (transactionToDelete.idIngreso != null) {
        final ingresoId = transactionToDelete.idIngreso!;
        final allTransactionsForThisIncome = await (select(transacciones)
              ..where((tbl) => tbl.idIngreso.equals(ingresoId)))
            .get();

        // First, check if deleting this income will result in a negative balance for any account.
        for (final tx in allTransactionsForThisIncome) {
          final cuenta = await db.cuentasDao.getCuentaById(tx.idCuenta);
          if (cuenta != null) {
            final newSaldo = cuenta.saldoActual - tx.cantidad;
            if (newSaldo < 0) {
              throw Exception(
                  'No se puede borrar el ingreso porque dejaría un saldo negativo en la cuenta ${cuenta.nombre}. Por favor, borre primero algún gasto.');
            }
          }
        }

        // If we are here, it means that no account will have a negative balance.
        // Now we can proceed with the deletion.
        for (final tx in allTransactionsForThisIncome) {
          final cuenta = await db.cuentasDao.getCuentaById(tx.idCuenta);
          if (cuenta != null) {
            final now = DateTime.now();
            final ingresoAcumulado =
                (tx.fecha.month == now.month && tx.fecha.year == now.year)
                    ? cuenta.ingresoAcumuladoMes - tx.cantidad
                    : cuenta.ingresoAcumuladoMes;

            final newSaldo = cuenta.saldoActual - tx.cantidad;

            await db.cuentasDao.upsertCuenta(cuenta
                .copyWith(
                  saldoActual: newSaldo,
                  ingresoAcumuladoMes: ingresoAcumulado,
                )
                .toCompanion(true));
          }
          await (delete(transacciones)..where((tbl) => tbl.id.equals(tx.id)))
              .go();
        }

        await db.ingresosDao.deleteIngreso(ingresoId);
      } else if (transactionToDelete.idGasto != null) {
        final gastoId = transactionToDelete.idGasto!;
        final allTransactionsForThisGasto = await (select(transacciones)
              ..where((tbl) => tbl.idGasto.equals(gastoId)))
            .get();

        for (final tx in allTransactionsForThisGasto) {
          final cuenta = await db.cuentasDao.getCuentaById(tx.idCuenta);
          if (cuenta != null) {
            final now = DateTime.now();
            // gasto transaction amount is negative, so we add it back
            final gastoAcumulado =
                (tx.fecha.month == now.month && tx.fecha.year == now.year)
                    ? cuenta.gastoAcumuladoMes + tx.cantidad
                    : cuenta.gastoAcumuladoMes;

            final newSaldo = cuenta.saldoActual - tx.cantidad;

            await db.cuentasDao.upsertCuenta(cuenta
                .copyWith(
                  // gasto transaction amount is negative, so we subtract it to add it back to the balance
                  saldoActual: newSaldo,
                  gastoAcumuladoMes: gastoAcumulado,
                )
                .toCompanion(true));
          }
          await (delete(transacciones)..where((tbl) => tbl.id.equals(tx.id)))
              .go();
        }

        await db.gastosDao.deleteGasto(gastoId);
      } else {
        // This handles transfers. We need to locate both transactions and revert them.
        if (transactionToDelete.tipo == TipoTransaccion.transferencia) {
          //This is a transfer, so we need to find the other transaction of the transfer and delete both
          final relatedTransactions = await (select(transacciones)
                ..where((tbl) =>
                    tbl.fecha.equals(transactionToDelete.fecha) &
                    tbl.tipo.equals(TipoTransaccion.transferencia.index) &
                    (tbl.id.equals(id).not()) &
                    tbl.cantidad.equals(-transactionToDelete.cantidad)))
              .get();

          // Check for negative balances before deleting
          for (final tx in relatedTransactions) {
            final cuenta = await db.cuentasDao.getCuentaById(tx.idCuenta);
            if (cuenta != null) {
              final newSaldo = cuenta.saldoActual - tx.cantidad;
              if (newSaldo < 0) {
                throw Exception(
                    'No se puede borrar la transferencia porque dejaría un saldo negativo en la cuenta ${cuenta.nombre}.');
              }
            }
          }
          final cuentaToDelete =
              await db.cuentasDao.getCuentaById(transactionToDelete.idCuenta);
          if (cuentaToDelete != null) {
            final newSaldo =
                cuentaToDelete.saldoActual - transactionToDelete.cantidad;
            if (newSaldo < 0) {
              throw Exception(
                  'No se puede borrar la transferencia porque dejaría un saldo negativo en la cuenta ${cuentaToDelete.nombre}.');
            }
          }

          for (final tx in relatedTransactions) {
            final cuenta = await db.cuentasDao.getCuentaById(tx.idCuenta);
            if (cuenta != null) {
              final newSaldo = cuenta.saldoActual - tx.cantidad;
              await db.cuentasDao.upsertCuenta(cuenta
                  .copyWith(
                    saldoActual: newSaldo,
                  )
                  .toCompanion(true));
            }
            await (delete(transacciones)..where((tbl) => tbl.id.equals(tx.id)))
                .go();
          }
        }

        final cuenta =
            await db.cuentasDao.getCuentaById(transactionToDelete.idCuenta);
        if (cuenta != null) {
          final newSaldo = cuenta.saldoActual - transactionToDelete.cantidad;
          if (newSaldo < 0) {
            throw Exception(
                'No se puede borrar la transacción porque dejaría un saldo negativo en la cuenta ${cuenta.nombre}.');
          }
          await db.cuentasDao.upsertCuenta(cuenta
              .copyWith(
                saldoActual: newSaldo,
              )
              .toCompanion(true));
        }
        await (delete(transacciones)..where((tbl) => tbl.id.equals(id))).go();
      }
    });
  }
}

@DriftAccessor(tables: [TransaccionesProgramadas])
class TransaccionesProgramadasDao extends DatabaseAccessor<AppDatabase>
    with _$TransaccionesProgramadasDaoMixin {
  TransaccionesProgramadasDao(super.db);

  Future<List<TransaccionProgramada>> get allTransaccionesProgramadas =>
      select(transaccionesProgramadas).get();
  Stream<List<TransaccionProgramada>> watchAllTransaccionesProgramadas() =>
      select(transaccionesProgramadas).watch();
  Future<void> upsertTransaccionProgramada(
          TransaccionesProgramadasCompanion transaccion) =>
      into(transaccionesProgramadas).insertOnConflictUpdate(transaccion);
  Future<void> deleteTransaccionProgramada(int id) =>
      (delete(transaccionesProgramadas)..where((tbl) => tbl.id.equals(id)))
          .go();
}

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});

@DriftAccessor(tables: [AppSettings])
class AppSettingsDao extends DatabaseAccessor<AppDatabase>
    with _$AppSettingsDaoMixin {
  AppSettingsDao(super.db);

  Future<AppSetting> getSettings() =>
      (select(appSettings)..where((tbl) => tbl.id.equals(1))).getSingle();
  Stream<AppSetting> watchSettings() {
    return (select(appSettings)..where((tbl) => tbl.id.equals(1)))
        .watch()
        .map((rows) => rows.single);
  }

  Future<int> updateSettings(AppSettingsCompanion settings) {
    return (update(appSettings)..where((tbl) => tbl.id.equals(1)))
        .write(settings);
  }
}

@DriftAccessor(tables: [Quotes])
class QuotesDao extends DatabaseAccessor<AppDatabase> with _$QuotesDaoMixin {
  QuotesDao(super.db);

  Future<Quote?> getUnusedQuote() async {
    final unusedQuotes = await (select(quotes)..where((q) => q.isUsed.equals(false))).get();
    if (unusedQuotes.isEmpty) {
      await (update(quotes)..where((q) => q.isUsed.equals(true))).write(const QuotesCompanion(isUsed: Value(false)));
      final allQuotes = await select(quotes).get();
      if (allQuotes.isEmpty) return null;
      final randomQuote = allQuotes[Random().nextInt(allQuotes.length)];
      await (update(quotes)..where((q) => q.id.equals(randomQuote.id))).write(const QuotesCompanion(isUsed: Value(true)));
      return randomQuote;
    } else {
      final randomQuote = unusedQuotes[Random().nextInt(unusedQuotes.length)];
      await (update(quotes)..where((q) => q.id.equals(randomQuote.id))).write(const QuotesCompanion(isUsed: Value(true)));
      return randomQuote;
    }
  }

  Future<void> addQuotes(List<QuotesCompanion> newQuotes) async {
    await batch((batch) {
      batch.insertAll(quotes, newQuotes);
    });
  }
}

@DriftAccessor(tables: [HistorialSaldos])
class HistorialSaldosDao extends DatabaseAccessor<AppDatabase>
    with _$HistorialSaldosDaoMixin {
  HistorialSaldosDao(super.db);

  Stream<List<HistorialSaldo>> watchAllHistorialSaldos() =>
      (select(historialSaldos)..orderBy([(t) => OrderingTerm(expression: t.fecha)])).watch();

  Future<void> insertHistorialSaldo(HistorialSaldosCompanion historialSaldo) =>
      into(historialSaldos).insert(historialSaldo);
}
