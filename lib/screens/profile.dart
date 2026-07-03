import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/providers/reminder_provider.dart';
import 'package:medalert/providers/user_provider.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final medicine = context.watch<MedicineProvider>().medicines;
    final user = context.read<UserProvider>().user;
    final reminder = context.watch<ReminderProvider>().reminder;

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
              CircleAvatar(radius: 40, child: Icon(Icons.person_2_rounded)),
              SizedBox(height: 12),
              Text(
                //name
                "${user[0].name[0].toUpperCase() + user[0].name.substring(1)}",
                style: GoogleFonts.poppins(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                //name
                "${user[0].profession}", //profession
                style: GoogleFonts.poppins(
                  fontSize: 18.9,
                  color: Colors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),

              SizedBox(height: 6),
              Divider(color: Colors.grey),
              SizedBox(height: 12),
              Row(
                children: [
                  Text(
                    "Your Stastics",
                    style: GoogleFonts.poppins(
                      fontSize: 27.5,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 6),
              Container(
                width: double.infinity,

                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(112, 255, 153, 0),
                  borderRadius: BorderRadius.circular(27.5),
                ),
                child: DefaultTextStyle(
                  style: TextStyle(fontSize: 14, color: Colors.white70),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "💊 Medicines Added :",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            '${medicine.length}',
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "⏰ Active reminders :",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${ReminderProvider().activeReminder}",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "✅ Today's Medicines :",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "${ReminderProvider().todayReminder}",
                            style: GoogleFonts.poppins(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ],
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
