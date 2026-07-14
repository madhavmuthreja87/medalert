import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:image_picker/image_picker.dart';
import 'package:medalert/models/user_model.dart';

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

  void saveUser(UserModel user) async {
    box.put("currentUser", {
      "uid": user.uid,
      "name": user.name,
      "email": user.email,
      "profession": user.profession,
      "photoUrl": user.photoUrl,
    });
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
    notifyListeners();
  }

  void logout() {
    box.delete("currentUser");
    notifyListeners();
  }

  final picker = ImagePicker();

  Future<void> pickImageAndSave() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    final String? path = file?.path;

    if (file == null) return;
    final currentUser = this.currentUser;
    if (currentUser == null) {
      return;
    }
    if (path != null) {
      currentUser.photoUrl = path;
      box.put(currentUser.uid, {
        "uid": currentUser.uid,
        "name": currentUser.name,
        "email": currentUser.email,
        "profession": currentUser.profession,
        "photoUrl": currentUser.photoUrl,
      });
    }
    notifyListeners();
  }
}
