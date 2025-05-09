import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'screens/home_screen.dart';
import 'services/database_helper.dart';
import 'services/hive_service.dart';
import 'package:provider/provider.dart';
import 'package:monity/providers/currency_provider.dart';

void main() async {
  // Configurar logging
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((record) {
    debugPrint('${record.level.name}: ${record.time}: ${record.message}');
  });

  final log = Logger('main');
  
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await HiveService.initHive();

    final dbHelper = DatabaseHelper();
    await dbHelper.clearCategories();

    log.info('Inicialización completada');
  } catch (e) {
    log.severe('Error durante la inicialización: $e');
  }

  runApp(
    ChangeNotifierProvider(
      create: (context) => CurrencyProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monity',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
