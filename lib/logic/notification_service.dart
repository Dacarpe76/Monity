import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class NotificationService {
  static final NotificationService _notificationService = NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> scheduleDailyMotivationalQuoteNotification(String quote) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'Tu impulso Monity del día 🚀',
        quote,
        _nextInstanceOfRandomTime(),
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily_motivational_quote_channel',
              'Daily Motivational Quote',
              channelDescription: 'Channel for daily motivational quotes',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  tz.TZDateTime _nextInstanceOfRandomTime() {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    final random = Random();
    // Random hour between 8 AM and 8 PM (20h)
    final randomHour = 8 + random.nextInt(13);
    final randomMinute = random.nextInt(60);

    tz.TZDateTime scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, randomHour, randomMinute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  Future<void> showTestNotification(String quote) async {
    await flutterLocalNotificationsPlugin.show(
        0,
        'Tu impulso Monity del día 🚀',
        quote,
        const NotificationDetails(
          android: AndroidNotificationDetails(
              'daily_motivational_quote_channel',
              'Daily Motivational Quote',
              channelDescription: 'Channel for daily motivational quotes',
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker'),
        ),
    );
  }

  Future<void> sendSavingsNotification(double savingsAmount) async {
    String title;
    String body;

    if (savingsAmount > 50) {
      title = '¡Enhorabuena! 🎉';
      body =
          '¡Gran trabajo! El mes pasado ahorraste ${savingsAmount.toStringAsFixed(2)}€. Sigue así.';
    } else if (savingsAmount >= 0) {
      title = '¡Puedes mejorar! 💪';
      body =
          'Ahorraste ${savingsAmount.toStringAsFixed(2)}€ el mes pasado. ¡Un pequeño empujón más este mes!';
    } else {
      title = '¡Ánimo! 🚀';
      body =
          'El mes pasado tuviste un balance de ${savingsAmount.toStringAsFixed(2)}€. ¡Este mes es una nueva oportunidad para empezar a ahorrar!';
    }

    await flutterLocalNotificationsPlugin.show(
      1, // Different ID from the daily quote
      title,
      body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'monthly_savings_channel',
          'Monthly Savings',
          channelDescription: 'Channel for monthly savings summary',
          importance: Importance.max,
          priority: Priority.high,
          ticker: 'ticker',
        ),
      ),
    );
  }

  Future<void> cancelAllNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
