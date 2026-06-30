import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/services/notification_services.dart';
import 'package:medalert/widgets/medicine_card.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final medicines = context.watch<MedicineProvider>().medicines;
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
              Text("Hello, Madhav", style: GoogleFonts.pacifico(fontSize: 18)),
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
                      NotificationServices().showNotification();
                      print("Notication testing");
                    },
                    child: Container(
                      width: double.infinity,

                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(244, 107, 86, 184),
                        borderRadius: BorderRadius.circular(27.5),
                      ),
                      child: DefaultTextStyle(
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                        child: Row(
                          mainAxisAlignment: .spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: .start,
                              mainAxisAlignment: .spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text(
                                      "Your next medicine in",
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      "45 mins",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: .start,
                                  children: [
                                    Text("Take your BP medicine Diuretics"),
                                    Text("tablets along with water"),
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
                    height: MediaQuery.sizeOf(context).height / 2.355,
                    child: ListView.builder(
                      itemCount: medicines.length,
                      itemBuilder: (context, index) {
                        return MedicineCard(
                          name: medicines[index].name,
                          desc: medicines[index].desc,
                          id: medicines[index].id,
                          quantity: medicines[index].quantity,
                        );
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 12.0),
                  //   child: Container(
                  //     width: double.infinity,
                  //     height: MediaQuery.sizeOf(context).height / 5,
                  //     padding: const EdgeInsets.all(20),
                  //     decoration: BoxDecoration(
                  //       color: const Color.fromARGB(130, 226, 165, 165),
                  //       borderRadius: BorderRadius.circular(30),
                  //     ),
                  //     child: DefaultTextStyle(
                  //       style: TextStyle(fontSize: 14, color: Colors.grey),
                  //       child: Row(
                  //         mainAxisAlignment: .spaceBetween,
                  //         children: [
                  //           Column(
                  //             crossAxisAlignment: .start,
                  //             mainAxisAlignment: .spaceBetween,
                  //             children: [
                  //               Column(
                  //                 crossAxisAlignment: .start,
                  //                 children: [
                  //                   Text(
                  //                     "Bacterium Tablets",
                  //                     style: TextStyle(
                  //                       fontWeight: FontWeight.w600,
                  //                       fontSize: 20,
                  //                       color: Colors.black,
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               Column(
                  //                 crossAxisAlignment: .start,
                  //                 children: [
                  //                   Text("Take your infection tablets"),
                  //                   Text("Bacterium along with water"),
                  //                 ],
                  //               ),
                  //             ],
                  //           ),
                  //           CircleAvatar(
                  //             maxRadius: 25,
                  //             backgroundColor: Colors.transparent,
                  //             child: Image.network(
                  //               "https://cdn-icons-png.flaticon.com/512/8638/8638176.png",
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
