import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:todo_app/src/task/domain/task.dart';

class NotificationService {
  static final notificationsList = StreamController<String>();
  NotificationService._();
  static final NotificationService _notificationService =
      NotificationService._();
  factory NotificationService() => _notificationService;
  final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    const initializationSettingsIOS = IOSInitializationSettings();
    const initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);

    await flutterLocalNotificationPlugin.initialize(
      initializationSettings,
      onSelectNotification: (payload) {
        if (payload == null) return;
        notificationsList.add(payload);
      },
    );
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  NotificationDetails _createNotificationDetails(Task task) =>
      NotificationDetails(
        android: AndroidNotificationDetails(task.id, task.title,
            channelDescription: task.description,
            importance: Importance.high,
            priority: Priority.high),
      );

  Future scheduleNextNotification(
      Task task, tz.TZDateTime scheduledDate) async {
    final details = _createNotificationDetails(task);

    await flutterLocalNotificationPlugin.zonedSchedule(
        int.parse(task.id),
        task.title,
        task.description,
        scheduledDate,
        details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
        payload: task.id);
  }

  Future cancelNotification(Task task) async =>
      flutterLocalNotificationPlugin.cancel(int.parse(task.id));
}
