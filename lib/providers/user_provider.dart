import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
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
}
