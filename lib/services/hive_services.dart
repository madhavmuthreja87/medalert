import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medalert/models/medicine_model.dart';
import 'package:medalert/models/reminder_model.dart';

class HiveServices {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(MedicineModelAdapter());
    Hive.registerAdapter(ReminderModelAdapter());
    await Hive.openBox<MedicineModel>("medicineBox");
    await Hive.openBox<ReminderModel>("reminderBox");

    await Hive.openBox("userBox");
  }
}
