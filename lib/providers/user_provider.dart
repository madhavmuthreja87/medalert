import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:image_picker/image_picker.dart';
import 'package:medalert/models/user_model.dart';

class UserProvider extends ChangeNotifier {
  final box = Hive.box("userBox");

  List<UserModel> get user => box.values.map((data) {
    return UserModel(
      name: data["name"],
      uid: data["uid"],
      profession: data["profession"],
      email: data["email"],
      photoUrl: data["photoUrl"],
    );
  }).toList();

  void addUser(UserModel user) {
    box.put(user.uid, {
      "uid": user.uid,
      "name": user.name,
      "email": user.email,
      "profession": user.profession,
      "photoUrl": user.photoUrl,
    });
    notifyListeners();
  }

  final picker = ImagePicker();

  Future<void> pickImageAndSave() async {
    XFile? file = await picker.pickImage(source: ImageSource.gallery);

    final String? path = file?.path;

    final UserModel currentUser = user[0];

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
    print(
      "!!!!!!!!!!!!!!!!!!!!!!!!!USER LENGTH: ${user.length}!!!!!!!!!!!!!!!!!!!!!!!!",
    );
    print("Image path: ${user[0].photoUrl}");
  }
}
