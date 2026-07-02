import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'reminder_model.g.dart';

@HiveType(typeId: 1)
class ReminderModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final int medicineId;

  @HiveField(2)
  final int hour;

  @HiveField(3)
  final int minute;

  @HiveField(4)
  final List<int> days;

  @HiveField(5)
  final bool isActive;

  ReminderModel({
    required this.id,
    required this.medicineId,
    required this.hour,
    required this.minute,
    required this.days,
    required this.isActive,
  });

  TimeOfDay get time => TimeOfDay(hour: hour, minute: minute);
}
