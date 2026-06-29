import 'package:flutter/material.dart';
import 'package:medalert/models/medicine_model.dart';

class MedicineProvider extends ChangeNotifier {
  final List<MedicineModel> _medicines = [];
  List<MedicineModel> get medicines => _medicines;

  void addMedicine(MedicineModel medicine) {
    _medicines.add(medicine);
    notifyListeners();
  }
}
