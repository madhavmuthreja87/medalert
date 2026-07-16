import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/main.dart';
import 'package:medalert/models/medicine_model.dart';
import 'package:medalert/models/reminder_model.dart';
import 'package:medalert/models/time_model.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/providers/reminder_provider.dart';
import 'package:medalert/services/notification_services.dart';
import 'package:provider/provider.dart';

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step1State();
}

class _Step1State extends State<Step2> {
  bool isMorning = false, isEvening = false, isNight = false;
  List<int> days = [];
  TextEditingController medicinenameController = TextEditingController();
  TextEditingController medicinedescController = TextEditingController();
  TextEditingController medicinequantityController = TextEditingController();
  // TextEditingController medicinetimeController = TextEditingController();
  TimeOfDay? selectedtime;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(79, 94, 193, 132),
          title: Text(
            "Add Medicine",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w700),
          ),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height / 7.1,
                    color: const Color.fromARGB(79, 94, 193, 132),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 80,
                        right: 80,
                        top: 20,
                      ),

                      child: SizedBox(
                        height: 10,
                        child: Container(
                          color: Colors.white,
                          child: Image.network(
                            fit: BoxFit.contain,
                            "https://cdn3d.iconscout.com/3d/premium/thumb/form-5979378-4949147.png",
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20.0,
                    ),
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: medicinenameController,

                        decoration: InputDecoration(
                          hintText: "Medicine name",
                          prefixIcon: Icon(Icons.medical_services_outlined),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20.0,
                    ),
                    child: SizedBox(
                      height: 100,
                      child: TextField(
                        controller: medicinedescController,

                        decoration: InputDecoration(
                          hintText: "Medicine description....",
                          prefixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 100),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10,
                      left: 20,
                      right: 20.0,
                    ),
                    child: SizedBox(
                      height: 45,
                      child: TextField(
                        controller: medicinequantityController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: "Quantity",
                          prefixIcon: Icon(Icons.production_quantity_limits),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),

                  // GestureDetector(
                  //   onTap: () async {
                  //     final TimeOfDay? pickedtime = await showTimePicker(
                  //       initialEntryMode: TimePickerEntryMode.input,
                  //       context: context,
                  //       initialTime: TimeOfDay.now(),
                  //     );
                  //     if (pickedtime != null) {
                  //       setState(() {
                  //         selectedtime = pickedtime;
                  //       });
                  //     }
                  //   },
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       top: 10.0,
                  //       left: 20,
                  //       right: 20,
                  //     ),

                  //     child: Container(
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.circular(10),
                  //         border: Border.all(
                  //           width: 1,
                  //           color: const Color.fromARGB(255, 108, 108, 108),
                  //         ),
                  //       ),
                  //       height: 40,
                  //       width: double.infinity,
                  //       child: Padding(
                  //         padding: const EdgeInsets.only(top: 4.0, left: 10),
                  //         child: Row(
                  //           children: [
                  //             Icon(Icons.timer),
                  //             SizedBox(width: 10),
                  //             selectedtime == null
                  //                 ? Text("Timing")
                  //                 : Text(
                  //                     "Timing:- ${selectedtime?.hour}:${selectedtime?.minute}  HH:MM ",
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.w500,
                  //                     ),
                  //                   ),
                  //           ],
                  //         ),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isMorning = !isMorning;
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text("Morning"),
                            ),
                            decoration: BoxDecoration(
                              color: isMorning
                                  ? const Color.fromARGB(205, 161, 253, 164)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isEvening = !isEvening;
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text("Evening"),
                            ),
                            decoration: BoxDecoration(
                              color: isEvening
                                  ? const Color.fromARGB(205, 161, 253, 164)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isNight = !isNight;
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(17.0),
                              child: Text(" Night "),
                            ),
                            decoration: BoxDecoration(
                              color: isNight
                                  ? const Color.fromARGB(205, 161, 253, 164)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  //------------Days--------------
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (days.contains(1)) {
                                days.remove((1));
                              } else
                                days.add(1);
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 17, 7, 17),
                              child: Text("Mon"),
                            ),
                            decoration: BoxDecoration(
                              color: days.contains(1)
                                  ? const Color.fromARGB(137, 65, 168, 252)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (days.contains(2)) {
                                days.remove((2));
                              } else
                                days.add(2);
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 17, 7, 17),
                              child: Text("Tue "),
                            ),
                            decoration: BoxDecoration(
                              color: days.contains(2)
                                  ? const Color.fromARGB(137, 65, 168, 252)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (days.contains(3)) {
                                days.remove((3));
                              } else
                                days.add(3);
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 17, 7, 17),
                              child: Text("Wed"),
                            ),
                            decoration: BoxDecoration(
                              color: days.contains(3)
                                  ? const Color.fromARGB(137, 65, 168, 252)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (days.contains(4)) {
                                days.remove((4));
                              } else
                                days.add(4);
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 17, 7, 17),
                              child: Text("Thu"),
                            ),
                            decoration: BoxDecoration(
                              color: days.contains(4)
                                  ? const Color.fromARGB(137, 65, 168, 252)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (days.contains(5)) {
                                days.remove((5));
                              } else
                                days.add(5);
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 17, 7, 17),
                              child: Text("Fri "),
                            ),
                            decoration: BoxDecoration(
                              color: days.contains(5)
                                  ? const Color.fromARGB(137, 65, 168, 252)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (days.contains(6)) {
                                days.remove((6));
                              } else
                                days.add(6);
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 17, 7, 17),
                              child: Text("Sat "),
                            ),
                            decoration: BoxDecoration(
                              color: days.contains(6)
                                  ? const Color.fromARGB(137, 65, 168, 252)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              if (days.contains(7)) {
                                days.remove((7));
                              } else
                                days.add(7);
                            });
                          },
                          child: Container(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(7, 17, 7, 17),
                              child: Text("Sun"),
                            ),
                            decoration: BoxDecoration(
                              color: days.contains(7)
                                  ? const Color.fromARGB(137, 65, 168, 252)
                                  : Colors.transparent,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  var medicineId = Random().nextInt(10000);
                  final medicine = MedicineModel(
                    id: medicineId,
                    name: medicinenameController.text,
                    desc: medicinedescController.text,
                    // hour: selectedtime!.hour,
                    // minute: selectedtime!.minute,
                    quantity: int.parse(medicinequantityController.text),
                  );
                  await context.read<MedicineProvider>().addMedicineToFirestore(
                    medicine,
                  );
                  context.read<MedicineProvider>().addMedicineToLocal(medicine);
                  print("!!!!!!!!!!!!Data added to medicine provider!!!!!!");

                  if (isMorning == true) {
                    //Reminder for morning
                    selectedtime = TimeOfDay(hour: 09, minute: 00);
                    final reminder = ReminderModel(
                      id: Random().nextInt(10000),
                      medicineId: medicineId,
                      days: days,
                      hour: selectedtime!.hour,
                      minute: selectedtime!.minute,
                      isActive: true,
                    );
                    context.read<ReminderProvider>().addReminder(reminder);
                    final now = DateTime.now();
                    // final scheduleTime = DateTime(
                    //   now.year,
                    //   now.month,
                    //   now.day,
                    //   // medicine.timing.hour,
                    //   // medicine.timing.minute,
                    //   reminder.time.hour,
                    //   reminder.time.minute,
                    // );
                    for (final r in reminder.days) {
                      final nextDate = TimeModel(
                        weekday: r,
                        hour: reminder.hour,
                        minute: reminder.minute,
                        year: now.year,
                        month: now.month,
                      );
                      await NotificationServices().scheduleNotification(
                        id: reminder.id * 10 + r,
                        title: medicine.name,
                        body: medicine.desc,
                        dateTime: nextDate.nextOccurrence,
                      );
                    }
                    print("Data added to MORNING reminder");
                  }

                  if (isEvening == true) {
                    //Reminder for evening
                    selectedtime = TimeOfDay(hour: 15, minute: 00);
                    final reminder = ReminderModel(
                      id: Random().nextInt(10000),
                      medicineId: medicineId,
                      days: days,
                      hour: selectedtime!.hour,
                      minute: selectedtime!.minute,
                      isActive: true,
                    );
                    context.read<ReminderProvider>().addReminder(reminder);
                    final now = DateTime.now();
                    // final scheduleTime = DateTime(
                    //   now.year,
                    //   now.month,
                    //   now.day,
                    //   // medicine.timing.hour,
                    //   // medicine.timing.minute,
                    //   reminder.time.hour,
                    //   reminder.time.minute,
                    // );
                    for (final r in reminder.days) {
                      final nextDate = TimeModel(
                        weekday: r,
                        hour: reminder.hour,
                        minute: reminder.minute,
                        month: now.month,
                        year: now.year,
                      );

                      await NotificationServices().scheduleNotification(
                        id: reminder.id * 10 + r,
                        title: medicine.name,
                        body: medicine.desc,
                        dateTime: nextDate.nextOccurrence,
                      );
                    }
                    print("Data added to EVENING reminder");
                  }

                  if (isNight == true) {
                    //Reminder for night
                    selectedtime = TimeOfDay(hour: 21, minute: 00);
                    final reminder = ReminderModel(
                      id: Random().nextInt(10000),
                      medicineId: medicineId,
                      days: days,
                      hour: selectedtime!.hour,
                      minute: selectedtime!.minute,
                      isActive: true,
                    );
                    context.read<ReminderProvider>().addReminder(reminder);
                    final now = DateTime.now();
                    // final scheduleTime = DateTime(
                    //   now.year,
                    //   now.month,
                    //   now.day,
                    //   // medicine.timing.hour,
                    //   // medicine.timing.minute,
                    //   reminder.time.hour,
                    //   reminder.time.minute,
                    // );
                    for (final r in reminder.days) {
                      final nextDate = TimeModel(
                        weekday: r,
                        hour: reminder.hour,
                        minute: reminder.minute,
                        year: now.year,
                        month: now.month,
                      );
                      await NotificationServices().scheduleNotification(
                        id: reminder.id * 10 + r,
                        title: medicine.name,
                        body: medicine.desc,
                        dateTime: nextDate.nextOccurrence,
                      );
                    }
                    print("Data added to NIGHT reminder");
                  }

                  // print("Data added to reminder provider");

                  // final now = DateTime.now();
                  // final scheduleTime = DateTime(
                  //   now.year,
                  //   now.month,
                  //   now.day,
                  //   // medicine.timing.hour,
                  //   // medicine.timing.minute,
                  //   reminder.time.hour,
                  //   reminder.time.minute,
                  // );
                  // await NotificationServices().scheduleNotification(
                  //   id: medicine.id,
                  //   title: medicine.name,
                  //   body: medicine.desc,
                  //   dateTime: scheduleTime,
                  // );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Medicine added!!!"),
                    ),
                  );
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => BottomNav()),
                    (route) => false,
                  );

                  final medicines = context.read<MedicineProvider>().medicines;
                  print("!!!!!!!!!Medicine model data!!!!!!!!!!!");
                  print("Medicine length: ${medicines.length}");
                  for (final m in medicines) {
                    print("${m.id}");
                    print("${m.name}");
                    print("${m.desc}");
                    // print("${m.timing}");
                    print("${m.quantity}");
                  }

                  final reminders = context.read<ReminderProvider>().reminder;
                  print("Reminder model data");
                  print("Reminder length: ${reminders.length}");
                  for (final r in reminders) {
                    print("${r.id}");
                    print("${r.medicineId}");
                    print("${r.time}");
                    print("${r.days}");
                    print("${r.isActive}");
                  }
                  print("!!!!!!!!!!!!!!!!!!  Done  !!!!!!!!!!!!!");
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 60, left: 20, right: 20),
                  width: double.infinity,
                  height: 50,

                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        offset: Offset(0, 2),
                        spreadRadius: 0.3,
                      ),
                    ],
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Next",
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.east, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
