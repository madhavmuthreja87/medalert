import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medalert/models/medicine_model.dart';

class MedicineProvider extends ChangeNotifier {
  final box = Hive.box<MedicineModel>("medicineBox");
  // final List<MedicineModel> _medicines = [];
  List<MedicineModel> get medicines => box.values.toList();

  void addMedicine(MedicineModel medicine) async {
    // _medicines.add(medicine);
    box.put(medicine.id, medicine);
    final currentUser = FirebaseAuth.instance.currentUser;
    final uid = currentUser?.uid;

    try {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(uid)
          .collection('medicines')
          .doc(medicine.id.toString())
          .set({
            "name": medicine.name,
            "desc": medicine.desc,
            "quantity": medicine.quantity,
            "reminder": DateTime.now(),
          });
    } on FirebaseException catch (e) {
      print(e.code);
    }
    notifyListeners();
  }

  void deleteMedicine(int id) {
    // _medicines.removeWhere((MedicineModel) => id == MedicineModel.id);
    box.delete(id);
    notifyListeners();
  }
}
