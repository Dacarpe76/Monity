import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/logic/notification_service.dart';
import 'package:monity/logic/work_manager_service.dart';
import 'package:monity/providers.dart';
import 'package:monity/ui/screens/home_screen.dart';
import 'package:logger/logger.dart';
import 'package:monity/ui/screens/setup_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest.dart' as tz;


void main() async {
  final logger = Logger();
  logger.d('Starting main function');
  // Asegura la inicialización de los bindings de Flutter
  WidgetsFlutterBinding.ensureInitialized();
  logger.d('WidgetsFlutterBinding initialized');

  await WorkManagerService().init();
  await WorkManagerService().registerDailyQuoteTask();
  await WorkManagerService().registerMonthlySavingsTask();
  await NotificationService().init();
  tz.initializeTimeZones();

  final prefs = await SharedPreferences.getInstance();
  final isSetupComplete = prefs.getBool('setup_complete') ?? false;

  // Crea un contenedor de providers para la inicialización
  final container = ProviderContainer();
  logger.d('ProviderContainer created');

  if (isSetupComplete) {
    // Usuario existente, ejecutar tareas de arranque
    final financeService = container.read(financeServiceProvider);
    logger.d('FinanceService created for existing user');
    // Automatic budget adjustment
    final now = DateTime.now();
    final lastAdjustmentString = prefs.getString('last_budget_adjustment_date');
    if (lastAdjustmentString == null) {
      await financeService.performMonthlyBudgetAdjustment();
      await prefs.setString('last_budget_adjustment_date', now.toIso8601String());
      logger.d('First time budget adjustment performed.');
    } else {
      final lastAdjustmentDate = DateTime.parse(lastAdjustmentString);
      if (now.month != lastAdjustmentDate.month || now.year != lastAdjustmentDate.year) {
        await financeService.performMonthlyBudgetAdjustment();
        await prefs.setString('last_budget_adjustment_date', now.toIso8601String());
        logger.d('Monthly budget adjustment performed.');
      }
    }

    await financeService.handleMonthlyReset();
    logger.d('Monthly reset handled');
    await financeService.recalculateMonthlyAccumulated();
    logger.d('Monthly accumulated recalculated');
    await financeService.checkAndExecuteScheduledIncomes();
    logger.d('Scheduled incomes checked');
    await financeService.checkAndExecuteScheduledTransfers();
    logger.d('Scheduled transfers checked');
    await financeService.checkAndExecuteScheduledExpenses();
    logger.d('Scheduled expenses checked');
    await financeService.checkAndExecuteCreditPayments();
    logger.d('Credit payments checked');
  }

  runApp(UncontrolledProviderScope(
    container: container,
    child: MyApp(isSetupComplete: isSetupComplete),
  ));
  logger.d('runApp called');
}

class MyApp extends StatelessWidget {
  final bool isSetupComplete;
  const MyApp({super.key, required this.isSetupComplete});

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
      home: isSetupComplete ? const HomeScreen() : const SetupScreen(),
    );
  }
}