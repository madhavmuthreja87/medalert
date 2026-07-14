import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/models/user_model.dart';
import 'package:medalert/providers/user_provider.dart';
import 'package:medalert/screens/sign_up.dart';
import 'package:provider/provider.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController emailController = TextEditingController();
  String email = "";
  final _formkey = GlobalKey<FormState>();
  Future forgotPassword() async {
    try {
      // ignore: unused_local_variable
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: const Color.fromARGB(238, 111, 97, 160),
          content: Text(
            'If user exists for this email, a password link has been sent.',
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
    } on FirebaseException catch (e) {
      print(e.code);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(e.code, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      );
    }
  }

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
                  text: "Forgot ",
                  style: GoogleFonts.poppins(
                    fontSize: 33,
                    fontWeight: FontWeight.w700,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "Passoword",
                      style: GoogleFonts.poppins(
                        fontSize: 33,
                        fontWeight: FontWeight.w700,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 80),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your email";
                            } else
                              return null;
                          },
                          decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 10),
                  ],
                ),
              ),

              SizedBox(height: 60),

              SizedBox(height: 40),
              SizedBox(
                height: 40,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(244, 107, 86, 184),
                    elevation: 25,
                    shadowColor: Colors.black,
                  ),

                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      email = emailController.text;

                      await forgotPassword();
                      final credential = FirebaseAuth.instance.currentUser;

                      final user = UserModel(
                        email: emailController.text,

                        photoUrl: "kmlk",
                        profession: "fds",
                        uid: credential?.uid ?? "Uid",
                        name: credential?.displayName ?? "User",
                      );
                      context.read<UserProvider>().saveUser(user);
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
              SizedBox(height: 40),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => SignUp()),
                  );
                },
                child: Text(
                  "Create an account ?",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
