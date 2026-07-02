import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medalert/models/reminder_model.dart';

class ReminderProvider extends ChangeNotifier {
  final Box<ReminderModel> box = Hive.box<ReminderModel>('reminderBox');
  List<ReminderModel> get reminder => box.values.toList();

  void addReminder(ReminderModel reminder) {
    box.put(reminder.id, reminder);
    notifyListeners();
  }

  void deleteReminderFull(int id) {
    final reminderToDelete = box.values
        .where((r) => r.medicineId == id)
        .toList();
    for (final reminder in reminderToDelete) {
      box.delete(reminder.id);
    }
    notifyListeners();
  }
}
