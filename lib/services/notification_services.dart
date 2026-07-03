import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';
import 'package:medalert/models/reminder_model.dart';
import 'package:medalert/providers/reminder_provider.dart';
import 'package:provider/provider.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:medalert/providers/medicine_provider.dart';

class NotificationServices {
  final FlutterLocalNotificationsPlugin notifications =
      FlutterLocalNotificationsPlugin();
  Future<void> initialize() async {
    tz.initializeTimeZones();
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
    );
    await notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        if (response.actionId == 'taken') {
          final box = Hive.box<ReminderModel>('reminderBox');
          int reminderID = response.id! ~/ 10;
          box.delete(reminderID);
        }
        print(
          '!!!!!!!!!!!!!!!!!!!!${response.actionId}!!!!!!!!!!!!!!!!!!!!!!!!!!!',
        );
      },
    );
  }

  Future<void> scheduleNotification({
    required int id,
    required String title,
    required String body,
    required DateTime dateTime,
  }) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'medicine_channel',
          'Medicine Reminder',
          actions: [
            AndroidNotificationAction(
              'taken',
              'Taken',
              showsUserInterface: true,
            ),
            AndroidNotificationAction('skip', 'Skip', showsUserInterface: true),
          ],
          channelDescription: "Medicine Reminder notification",
          importance: Importance.max,
          priority: Priority.high,
        );
    const NotificationDetails details = NotificationDetails(
      android: androidDetails,
    );

    final scheduledDate = tz.TZDateTime.from(dateTime, tz.local);
    await notifications.zonedSchedule(
      id,
      '💊 Medicine Reminder',
      'Time to take $title',
      scheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
    );
    // notifications
    print("Reminder set!!!!!!!!!!!");
  }

  //   Future<void> showNotification() async {
  //     const AndroidNotificationDetails androidDetails =
  //         AndroidNotificationDetails(
  //           'medicine_channel',
  //           'Medicine Reminder',
  //           channelDescription: "Medicine Reminder notification",
  //           importance: Importance.max,
  //           priority: Priority.high,
  //         );
  //     const NotificationDetails details = NotificationDetails(
  //       android: androidDetails,
  //     );

  //     await notifications.show(
  //       0,
  //       '💊 Medicine Reminder',

  //       'Time to take Paracetamol',
  //       details,
  //     );
  //   }
}
