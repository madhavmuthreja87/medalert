import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medalert/models/nearest_reminder_model.dart';
import 'package:medalert/models/reminder_model.dart';
import 'package:medalert/models/time_model.dart';

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

  int get activeReminder {
    int total = 0;
    for (final r in box.values) {
      total += r.days.length;
    }
    return total;
  }

  NearestReminderModel get nearestReminder {
    NearestReminderModel? nearesttime;
    Duration? smallestDifference;
    DateTime timenow = DateTime.now();
    for (final r in box.values) {
      var reminderTime;
      for (final d in r.days) {
        reminderTime = TimeModel(
          weekday: d,
          hour: r.hour,
          minute: r.minute,
          year: timenow.year,
          month: timenow.month,
        ).nextOccurrence;
        print(
          'MedicineId: ${r.medicineId}, '
          'Day: $d, '
          'Reminder: $reminderTime, '
          'Now: $timenow',
        );

        if (reminderTime.isBefore(timenow)) continue;

        final difference = reminderTime.difference(timenow);
        print('!!!!!!!!!!!!!!!!Difference: $difference !!!!!!!!!!!!!!!');
        if (smallestDifference == null || smallestDifference > difference) {
          smallestDifference = difference;
          // nearesttime = r;
          nearesttime = NearestReminderModel(
            reminder: r,
            nexttime: reminderTime,
          );
        }
      }
    }
    return nearesttime!;
  }
}
