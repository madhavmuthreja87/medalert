import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medalert/models/medicine_model.dart';

class MedicineProvider extends ChangeNotifier {
  final Box<MedicineModel> box = Hive.box<MedicineModel>("medicineBox");
  // final List<MedicineModel> _medicines = [];
  List<MedicineModel> get medicines => box.values.toList();

  void addMedicineToLocal(MedicineModel medicine) {
    // _medicines.add(medicine);
    box.put(medicine.id, medicine);

    notifyListeners();
  }

  Future<void> addMedicineToFirestore(MedicineModel medicine) async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser?.uid;

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('medicines')
          .doc(medicine.id.toString())
          .set({
            "id": medicine.id,
            "name": medicine.name,
            "desc": medicine.desc,
            "quantity": medicine.quantity,
            "reminder": DateTime.now(),
          });
    } on FirebaseException catch (e) {
      print("!!!!!!!!!!!!!!!!!!!!!!!        Logout Error: $e.code");
    }
  }

  void deleteMedicine(int id) {
    // _medicines.removeWhere((MedicineModel) => id == MedicineModel.id);
    box.delete(id);
    notifyListeners();
  }

  MedicineModel findById(int id) {
    return medicines.firstWhere((medicine) => medicine.id == id);
  }
}
