import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/main.dart';
import 'package:medalert/models/medicine_model.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/screens/home_screen.dart';
import 'package:provider/provider.dart';

class Step2 extends StatefulWidget {
  const Step2({super.key});

  @override
  State<Step2> createState() => _Step1State();
}

class _Step1State extends State<Step2> {
  TextEditingController medicinenameController = TextEditingController();
  TextEditingController medicinedescController = TextEditingController();
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
                  SizedBox(height: 50),
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
                          prefixIcon: Icon(Icons.remove_red_eye),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          contentPadding: EdgeInsets.symmetric(vertical: 100),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? pickedtime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedtime != null) {
                        setState(() {
                          selectedtime = pickedtime;
                        });
                      }
                    },
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      child: Text("Timing"),
                    ),
                  ),
                ],
              ),

              GestureDetector(
                onTap: () {
                  final medicine = MedicineModel(
                    name: medicinenameController.text,
                    desc: medicinedescController.text,
                    timing: selectedtime!,
                  );
                  context.read<MedicineProvider>().addMedicine(medicine);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BottomNav()),
                  );
                  final medicines = context.read<MedicineProvider>().medicines;
                  for (final m in medicines) {
                    print("${m.name}");
                    print("${m.desc}");
                    print("${m.timing}");
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
