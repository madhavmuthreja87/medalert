import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/main.dart';
import 'package:medalert/models/medicine_model.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/screens/home_screen.dart';
import 'package:medalert/services/notification_services.dart';
import 'package:provider/provider.dart';

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step1State();
}

class _Step1State extends State<Step2> {
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
            mainAxisAlignment: .spaceBetween,
            children: [
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: MediaQuery.sizeOf(context).height / 4.2,
                    color: const Color.fromARGB(79, 94, 193, 132),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 80,
                        right: 80,
                        top: 80,
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
                  SizedBox(height: 40),
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

                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? pickedtime = await showTimePicker(
                        initialEntryMode: TimePickerEntryMode.input,
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedtime != null) {
                        setState(() {
                          selectedtime = pickedtime;
                        });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10.0,
                        left: 20,
                        right: 20,
                      ),

                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: const Color.fromARGB(255, 108, 108, 108),
                          ),
                        ),
                        height: 40,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 4.0, left: 10),
                          child: Row(
                            children: [
                              Icon(Icons.timer),
                              SizedBox(width: 10),
                              selectedtime == null
                                  ? Text("Timing")
                                  : Text(
                                      "Timing:- ${selectedtime?.hour}:${selectedtime?.minute}  HH:MM ",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              GestureDetector(
                onTap: () async {
                  final medicine = MedicineModel(
                    id: Random().nextInt(10000),
                    name: medicinenameController.text,
                    desc: medicinedescController.text,
                    timing: selectedtime!,
                    quantity: int.parse(medicinequantityController.text),
                  );
                  context.read<MedicineProvider>().addMedicine(medicine);
                  final now = DateTime.now();
                  final scheduleTime = DateTime(
                    now.year,
                    now.month,
                    now.day,
                    medicine.timing.hour,
                    medicine.timing.minute,
                  );
                  await NotificationServices().scheduleNotification(
                    id: medicine.id,
                    title: medicine.name,
                    body: medicine.desc,
                    dateTime: scheduleTime,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.green,
                      content: Text("Medicine added!!!"),
                    ),
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNav()),
                  );
                  final medicines = context.read<MedicineProvider>().medicines;
                  for (final m in medicines) {
                    print("${m.id}");
                    print("${m.name}");
                    print("${m.desc}");
                    print("${m.timing}");
                    print("${m.quantity}");
                  }
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
                      mainAxisAlignment: .center,
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
