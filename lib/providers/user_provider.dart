import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
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

  void saveUser(UserModel user) {
    box.put("currentUser", {
      "uid": user.uid,
      "name": user.name,
      "email": user.email,
      "profession": user.profession,
      "photoUrl": user.photoUrl,
    });
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
