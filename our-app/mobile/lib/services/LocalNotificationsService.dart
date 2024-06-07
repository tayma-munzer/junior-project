import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final NotificationService _notificationService =
  NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid, macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> ShowNotification(
      {required String title, required String body}) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      "1", //Required for Android 8.0 or after
      "default", //Required for Android 8.0 or after
      channelDescription:
      "this is the default channel", //Required for Android 8.0 or after
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails platformChannelSpecifics =
    NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      12345,
      title,
      body,
      platformChannelSpecifics,
    );
  }
}
