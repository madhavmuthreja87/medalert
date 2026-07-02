import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'medicine_model.g.dart';

@HiveType(typeId: 0)
class MedicineModel extends HiveObject {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String desc;

  // @HiveField(3)
  // final int hour;

  // @HiveField(4)
  // final int minute;

  @HiveField(5)
  final int quantity;

  MedicineModel({
    required this.id,
    required this.name,
    required this.desc,
    // required this.hour,
    // required this.minute,
    required this.quantity,
  });

  // TimeOfDay get timing => TimeOfDay(hour: hour, minute: minute);
}
