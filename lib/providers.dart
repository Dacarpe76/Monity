import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/logic/finance_service.dart';

// Providers para los DAOs
final cuentasDaoProvider = Provider<CuentasDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.cuentasDao;
});

final categoriasDaoProvider = Provider<CategoriasDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.categoriasDao;
});

final ingresosDaoProvider = Provider<IngresosDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.ingresosDao;
});

final gastosDaoProvider = Provider<GastosDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.gastosDao;
});

final transaccionesDaoProvider = Provider<TransaccionesDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.transaccionesDao;
});

final transaccionesProgramadasDaoProvider =
    Provider<TransaccionesProgramadasDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.transaccionesProgramadasDao;
});

final appSettingsDaoProvider = Provider<AppSettingsDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.appSettingsDao;
});



// Provider para el servicio de finanzas
final financeServiceProvider = Provider<FinanceService>((ref) {
  final db = ref.watch(databaseProvider);
  return FinanceService(db);
});

final unsortedCategoriesProvider = StreamProvider<List<Categoria>>((ref) {
  final dao = ref.watch(categoriasDaoProvider);
  return dao.watchAllCategorias();
});

final sortedCategoriesProvider = StreamProvider<List<CategoriaWithUsage>>((ref) {
  final dao = ref.watch(categoriasDaoProvider);
  return dao.watchAllCategoriasSorted();
});

final appSettingsProvider = StreamProvider<AppSetting>((ref) {
  final dao = ref.watch(appSettingsDaoProvider);
  return dao.watchSettings();
});

final showAmountsProvider = StateProvider<bool>((ref) => true);