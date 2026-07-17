import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hive/hive.dart';

import 'package:image_picker/image_picker.dart';
import 'package:medalert/models/medicine_model.dart';
import 'package:medalert/models/reminder_model.dart';
import 'package:medalert/models/user_model.dart';
import 'package:medalert/services/notification_services.dart';

class UserProvider extends ChangeNotifier {
  final Box box = Hive.box("userBox");

  UserModel? get currentUser {
    final data = box.get("currentUser");
    if (data == null) return null;

    return UserModel(
      name: data["name"],
      uid: data["uid"],
      profession: data["profession"],
      email: data["email"],
      photoUrl: data["photoUrl"],
    );
  }

  void saveUserLocal(UserModel user) {
    box.put("currentUser", {
      "uid": user.uid,
      "name": user.name,
      "email": user.email,
      "profession": user.profession,
      "photoUrl": user.photoUrl,
    });

    notifyListeners();
  }

  Future<void> saveUserToFirestore(UserModel user) async {
    //Adding data into firebase Firestore
    final uid = FirebaseAuth.instance.currentUser?.uid;
    try {
      await FirebaseFirestore.instance.collection('Users').doc(uid).set({
        "name": user.name,
        "email": user.email,
        "profession": user.profession,
        "photoUrl": user.photoUrl,
      });
      print("Data saved to fire base");
    } on FirebaseException catch (e) {
      print(e.code);
    }
  }

  Future<void> logout() async {
    print("Log out started");

    await NotificationServices().cancelAllNotifications();
    print("Cancelling all notifications");

    await Hive.box<MedicineModel>("medicineBox").clear();
    debugPrint("Medicine deleted");

    await Hive.box<ReminderModel>("reminderBox").clear();
    debugPrint("Reminder deleted");

    await Hive.box("userBox").clear();
    debugPrint("User details deleted");

    await FirebaseAuth.instance.signOut();
    debugPrint("Sign out from firebase");

    await GoogleSignIn.instance.signOut();
    debugPrint("Sign out from Google");

    print(
      "!!!!!!!!!!!!!!!!!!!!!!!!!           deleted all stuff          !!!!!!!!!!!!!!!!!!!!!",
    );
    notifyListeners();
  }

  final picker = ImagePicker();

  Future<void> pickImageAndSave() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);
    print("!!!!!!!!!!!!!!!!!!!!!!!!Image picked");
    final String? path = file?.path;

    if (file == null) return;
    final currentUser = this.currentUser;
    if (currentUser == null) {
      return;
    }
    if (path != null) {
      currentUser.photoUrl = path;
      box.put("currentUser", {
        "uid": currentUser.uid,
        "name": currentUser.name,
        "email": currentUser.email,
        "profession": currentUser.profession,
        "photoUrl": currentUser.photoUrl,
      });
      final uid = FirebaseAuth.instance.currentUser?.uid;
      try {
        await FirebaseFirestore.instance.collection('Users').doc(uid).update({
          "photoUrl": path,
        });
        print("Image saved to firebase firestore!!!!!!!!!!!!!");
      } on FirebaseAuthException catch (e) {
        print(e.code);
      }
    }
    print("Image saved!!!!!!!!!!!!!!!!!!!!!!!!!!");
    notifyListeners();
  }
}
