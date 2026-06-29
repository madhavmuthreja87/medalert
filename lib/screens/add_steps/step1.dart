import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/screens/add_steps/step2.dart';

class Step1 extends StatefulWidget {
  const Step1({super.key});

  @override
  State<Step1> createState() => _Step1State();
}

class _Step1State extends State<Step1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(79, 216, 78, 28),
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
            Container(
              width: double.infinity,
              height: MediaQuery.sizeOf(context).height / 4.2,
              color: const Color.fromARGB(79, 216, 78, 28),
              child: Padding(
                padding: const EdgeInsets.only(left: 80, right: 80, top: 80),

                child: SizedBox(
                  height: 10,
                  child: Container(
                    color: Colors.white,
                    child: Image.network(
                      "https://tse1.mm.bing.net/th/id/OIP.EL433T0jkZuDWxnBtAbtvwHaHa?r=0&rs=1&pid=ImgDetMain&o=7&rm=3",
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Step2()),
                );
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
    );
  }
}
