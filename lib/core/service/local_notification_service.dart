import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  static Future<void> init() async {
    InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      ),
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> scadualNotification({
    required int id,
    required String title,
    String? body,
    required DateTime localTime,
    NotificationDetails? details,
    String? payload,
  }) async {
    final when = tz.TZDateTime.from(localTime, tz.local);
    if (!when.isAfter(DateTime.now())) return;
    flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      when,
      details ?? const NotificationDetails(),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: payload,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  Future<void> cancelAll() => flutterLocalNotificationsPlugin.cancelAll();

  void changeTimezone(String tzName) {
    tz.setLocalLocation(tz.getLocation(tzName));
  }
}
