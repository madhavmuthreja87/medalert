import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/models/medicine_model.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/providers/reminder_provider.dart';
import 'package:medalert/providers/user_provider.dart';
import 'package:medalert/services/notification_services.dart';
import 'package:medalert/widgets/medicine_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final ScrollController _scrollController = ScrollController();
  Timer? timer;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      if (mounted) {
        print("!!!!!!!!!!1HOME SCREEN BUILT!!!!!!!!!1");
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final medicines = context.watch<MedicineProvider>().medicines;
    final user = context.watch<UserProvider>().user;
    final todayMedicineID = context.watch<ReminderProvider>().todayMedicineId;
    final todayMedicines = medicines
        .where((m) => todayMedicineID.contains(m.id))
        .toList();
    final nearestReminder = context.watch<ReminderProvider>().nearestReminder;

    final diff = nearestReminder.nexttime.difference(DateTime.now());

    MedicineModel? nearestMedicineDetails() {
      final nearstmedicineId = nearestReminder.reminder.medicineId;
      for (final m in medicines) {
        if (m.id == nearstmedicineId) {
          return m;
        }
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MedAlert",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // SizedBox(height: MediaQuery.sizeOf(context).height / 100),
              CircleAvatar(child: Icon(Icons.person_2_rounded)),
              SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  text: "Hello, ",
                  style: GoogleFonts.pacifico(fontSize: 20),
                  children: <InlineSpan>[
                    TextSpan(
                      text:
                          user[0].name[0].toUpperCase() +
                          user[0].name.substring(1),
                      style: GoogleFonts.pacifico(fontSize: 18),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12),
              Text.rich(
                TextSpan(
                  text: "Your medicines for ",
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "today",
                      style: GoogleFonts.poppins(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 13),
              Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      for (final tdmid in todayMedicineID) {
                        print(tdmid);
                      }
                    },
                    child: Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 119, 98, 195),
                        borderRadius: BorderRadius.circular(22.5),

                        boxShadow: [
                          BoxShadow(
                            blurRadius: 4.2,
                            offset: Offset(-2.5, 4),
                            color: Colors.black87,
                            spreadRadius: 1.5,
                          ),
                        ],
                      ),
                      child: DefaultTextStyle(
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Your next medicine in",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 22,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        diff.inHours != 0
                                            ? Text(
                                                "${diff.inHours} hour and ",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 20,
                                                ),
                                              )
                                            : Text(""),
                                        Text(
                                          "${diff.inMinutes % 60} minutes",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text("Take your "),
                                        Text(
                                          '${nearestMedicineDetails()?.name}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 22,
                                          ),
                                        ),
                                        Text(" medicine"),
                                      ],
                                    ),
                                    Text("${nearestMedicineDetails()?.desc}"),
                                  ],
                                ),
                              ],
                            ),
                            CircleAvatar(
                              maxRadius: 25,
                              backgroundColor: Colors.transparent,
                              child: Image.network(
                                "https://cdn1.iconfinder.com/data/icons/volunteer-6/48/medicine_pharmaceutical_pharmacy_tablet_medication-512.png",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 7),
                  Container(
                    height: MediaQuery.sizeOf(context).height / 2.7,
                    child: Scrollbar(
                      //  controller: _scrollController,
                      radius: Radius.circular(30),
                      trackVisibility: true,
                      thumbVisibility: true,

                      child: ListView.builder(
                        itemCount: todayMedicines.length,

                        itemBuilder: (context, index) {
                          final medicine = todayMedicines[index];
                          return MedicineCard(
                            name: medicine.name,
                            desc: medicine.desc,
                            medicineId: medicine.id,
                            quantity: medicine.quantity,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
