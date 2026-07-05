import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/main.dart';
import 'package:medalert/models/user_model.dart';
import 'package:medalert/providers/user_provider.dart';
import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  text: "Create ",
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "Account",
                      style: GoogleFonts.poppins(
                        fontSize: 35,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 100),
              SizedBox(
                height: 63,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 63,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 63,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextField(
                    controller: professionController,
                    decoration: InputDecoration(
                      labelText: "Profession",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 100),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(244, 107, 86, 184),
                    elevation: 25,
                    shadowColor: Colors.black,
                  ),

                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty &&
                        professionController.text.isNotEmpty) {
                      final user = UserModel(
                        email: emailController.text,
                        name: nameController.text,
                        photoUrl: "fdfgdf",
                        profession: professionController.text,
                        uid: Random().nextInt(100),
                      );
                      context.read<UserProvider>().addUser(user);
                      print("User created!!!!!!!!!");
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => BottomNav()),
                      );
                    }
                  },
                  child: Text(
                    "Continue",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
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
