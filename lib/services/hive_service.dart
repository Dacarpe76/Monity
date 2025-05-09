import 'package:hive_flutter/hive_flutter.dart';
import 'package:logging/logging.dart';
import '../models/account.dart';
import '../models/category.dart';
import '../models/transaction.dart';

class HiveService {
  static final _log = Logger('HiveService');

  static Future<void> initHive() async {
    _log.info('Iniciando Hive...');

    await Hive.initFlutter();

    // Registrar adaptadores
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(AccountAdapter());
      _log.info('Adaptador de Account registrado');
    }

    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(TransactionAdapter());
      _log.info('Adaptador de Transaction registrado');
    }

    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(CategoryAdapter());
      _log.info('Adaptador de Category registrado');
    }

    // Abrir boxes
    await Hive.openBox<Account>('accounts');
    await Hive.openBox<Transaction>('transactions');
    await Hive.openBox<Category>('categories');

    _log.info('Hive inicializado correctamente');
  }

  static Future<void> saveBoxes() async {
    _log.info('Guardando boxes de Hive...');

    final accountsBox = Hive.box<Account>('accounts');
    final transactionsBox = Hive.box<Transaction>('transactions');
    final categoriesBox = Hive.box<Category>('categories');

    await Future.wait([
      accountsBox.compact(),
      transactionsBox.compact(),
      categoriesBox.compact(),
    ]);

    _log.info('Boxes guardados correctamente');
  }
}
