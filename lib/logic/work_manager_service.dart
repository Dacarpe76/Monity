import 'dart:io' show Platform;
import 'package:workmanager/workmanager.dart';
import 'package:monity/logic/notification_service.dart';
import 'package:monity/data/database.dart';
import 'package:monity/logic/finance_service.dart';

const dailyQuoteTask = "dailyQuote";
const monthlySavingsTask = "monthlySavings";

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final db = AppDatabase();
    final notificationService = NotificationService();
    await notificationService.init();

    switch (task) {
      case dailyQuoteTask:
        final quote = await db.quotesDao.getUnusedQuote();
        if (quote != null) {
          await notificationService
              .scheduleDailyMotivationalQuoteNotification(quote.quoteText);
        }
        break;
      case monthlySavingsTask:
        final now = DateTime.now();
        if (now.day == 1) {
          final financeService = FinanceService(db);
          final savings = await financeService.calculatePreviousMonthSavings();
          await notificationService.sendSavingsNotification(savings);
        }
        break;
    }
    return Future.value(true);
  });
}

class WorkManagerService {
  static final WorkManagerService _workManagerService =
      WorkManagerService._internal();

  factory WorkManagerService() {
    return _workManagerService;
  }

  WorkManagerService._internal();

  Future<void> init() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await Workmanager().initialize(
        callbackDispatcher,
        isInDebugMode: true,
      );
    }
  }

  Future<void> registerDailyQuoteTask() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await Workmanager().registerPeriodicTask(
        '1',
        dailyQuoteTask, // Use the constant
        frequency: const Duration(days: 1),
      );
    }
  }

  Future<void> registerMonthlySavingsTask() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await Workmanager().registerPeriodicTask(
        '2', // Different ID
        monthlySavingsTask, // Use the constant
        frequency: const Duration(days: 1), // Run daily to check the day
      );
    }
  }

  Future<void> cancelAllTasks() async {
    if (Platform.isAndroid || Platform.isIOS) {
      await Workmanager().cancelAll();
    }
  }
}
