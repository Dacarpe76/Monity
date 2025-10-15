import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/providers.dart';
import 'package:monity/ui/screens/home_screen.dart';
import 'package:logger/logger.dart';

void main() async {
  final logger = Logger();
  logger.d('Starting main function');
  // Asegura la inicialización de los bindings de Flutter
  WidgetsFlutterBinding.ensureInitialized();
  logger.d('WidgetsFlutterBinding initialized');

  // Crea un contenedor de providers para la inicialización
  final container = ProviderContainer();
  logger.d('ProviderContainer created');

  // Inicializa la base de datos y ejecuta tareas de arranque
  final financeService = container.read(financeServiceProvider);
  logger.d('FinanceService created');
  await financeService.initializeDatabase();
  logger.d('Database initialized');
  await financeService.handleMonthlyReset();
  logger.d('Monthly reset handled');
  await financeService.recalculateMonthlyAccumulated();
  logger.d('Monthly accumulated recalculated');
  await financeService.checkAndExecuteScheduledTransactions();
  logger.d('Scheduled transactions checked');
  await financeService.checkAndExecuteCreditPayments();
  logger.d('Credit payments checked');

  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
  logger.d('runApp called');
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Monity',
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''), // English, no country code
        Locale('es', ''), // Spanish, no country code
      ],
      locale: const Locale('es', ''),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.light),
        useMaterial3: true,
        brightness: Brightness.light,
      ),
      home: const HomeScreen(),
    );
  }
}