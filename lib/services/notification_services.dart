import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  Future<void> initialize() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );
    await notifications.initialize(settings);
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'medicine_channel',
          'Medicine Reminder',
          channelDescription: "Medicine Reminder notification",
          importance: Importance.max,
          priority: Priority.high,
        );
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );
    await notifications.show(
      0,
      '💊 Medicine Reminder',

      'Time to take Paracetamol',
      details,
    );
  }
}
