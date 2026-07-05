import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medalert/models/medicine_model.dart';
import 'package:medalert/providers/reminder_provider.dart';

class MedicineProvider extends ChangeNotifier {
  final box = Hive.box<MedicineModel>("medicineBox");
  // final List<MedicineModel> _medicines = [];
  List<MedicineModel> get medicines => box.values.toList();

  void addMedicine(MedicineModel medicine) {
    // _medicines.add(medicine);
    box.put(medicine.id, medicine);
    notifyListeners();
  }

  void deleteMedicine(int id) {
    // _medicines.removeWhere((MedicineModel) => id == MedicineModel.id);
    box.delete(id);
    notifyListeners();
  }
}
