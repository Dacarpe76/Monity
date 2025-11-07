import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/currencies.dart';
import 'package:monity/data/database.dart';
import 'package:monity/logic/finance_service.dart';
import 'package:monity/logic/work_manager_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

final premiosDaoProvider = Provider<PremiosDao>((ref) {
  final db = ref.watch(databaseProvider);
  return db.premiosDao;
});



// Provider para el servicio de finanzas
final financeServiceProvider = Provider<FinanceService>((ref) {
  final db = ref.watch(databaseProvider);
  return FinanceService(db);
});

final cuentasProvider = StreamProvider<List<Cuenta>>((ref) {
  final dao = ref.watch(cuentasDaoProvider);
  return dao.watchAllCuentas();
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

final currencyProvider = Provider<Currency>((ref) {
  final settings = ref.watch(appSettingsProvider);
  
  return settings.when(
    data: (appSettings) {
      return supportedCurrencies.firstWhere(
        (c) => c.code == appSettings.currency,
        orElse: () => supportedCurrencies.firstWhere((c) => c.code == 'EUR'),
      );
    },
    loading: () => supportedCurrencies.firstWhere((c) => c.code == 'EUR'), // Default while loading
    error: (_, __) => supportedCurrencies.firstWhere((c) => c.code == 'EUR'), // Default on error
  );
});

final showAmountsProvider = StateProvider<bool>((ref) => true);

final motivationalQuotesProvider = StateNotifierProvider<MotivationalQuotesNotifier, bool>((ref) {
  return MotivationalQuotesNotifier();
});

class MotivationalQuotesNotifier extends StateNotifier<bool> {
  MotivationalQuotesNotifier() : super(false) {
    _loadState();
  }

  Future<void> _loadState() async {
    final prefs = await SharedPreferences.getInstance();
    state = prefs.getBool('motivational_quotes_enabled') ?? false;
  }

  Future<void> toggle(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('motivational_quotes_enabled', value);
    state = value;

    if (state) {
      WorkManagerService().registerDailyQuoteTask();
    } else {
      WorkManagerService().cancelDailyQuoteTask();
    }
  }
}