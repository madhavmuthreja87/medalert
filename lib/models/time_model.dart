class TimeModel {
  final int weekday;
  final int hour;
  final int minute;
  final int year;
  final int month;

  TimeModel({
    required this.weekday,
    required this.hour,
    required this.minute,
    required this.year,
    required this.month,
  });
  DateTime get nextOccurrence {
    DateTime now = DateTime.now();

    DateTime next = DateTime(now.year, now.month, now.day, hour, minute);

    while (next.weekday != weekday || next.isBefore(now)) {
      next = next.add(const Duration(days: 1));
    }

    return next;
  }
}
