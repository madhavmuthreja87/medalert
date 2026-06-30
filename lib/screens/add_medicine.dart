import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/screens/add_steps/step1.dart';

class AddMedicine extends StatefulWidget {
  const AddMedicine({super.key});

  @override
  State<AddMedicine> createState() => _AddMedicineState();
}

class _AddMedicineState extends State<AddMedicine> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "MedAlert",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.sizeOf(context).height / 30),
                    Text(
                      "Add",
                      style: GoogleFonts.poppins(
                        fontSize: 26,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height / 5,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(152, 161, 146, 214),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: DefaultTextStyle(
                        style: TextStyle(
                          fontSize: 15,
                          color: const Color.fromARGB(255, 116, 115, 115),
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
                                      "Medicine",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 25,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text("Add medicine and time.And rest"),
                                    Text("we will make sure to remind you"),
                                    Text("about taking your pills on time"),
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
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Step1()),
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(bottom: 60),
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
                          "Add",
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
