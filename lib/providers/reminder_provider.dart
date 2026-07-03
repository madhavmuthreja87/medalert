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

  List<int> get todayMedicineId {
    List<int> mid = [];
    DateTime time = DateTime.now();
    for (final r in box.values) {
      if (r.days.contains(time.weekday)) {
        mid.add(r.medicineId);
      }
    }
    return mid;
  }

  int get activeReminder {
    int total = 0;
    for (final r in box.values) {
      total += r.days.length;
    }
    return total;
  }

  int get todayReminder {
    int total = 0;
    DateTime time = DateTime.now();
    for (final r in box.values) {
      if (r.days.contains(time.weekday)) {
        total++;
      }
    }
    return total;
  }
}
