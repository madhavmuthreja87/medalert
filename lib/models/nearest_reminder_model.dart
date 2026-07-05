import 'package:medalert/models/reminder_model.dart';

class NearestReminderModel {
  final ReminderModel reminder;
  final DateTime nexttime;
  NearestReminderModel({required this.reminder, required this.nexttime});
}
