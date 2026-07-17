import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/main.dart';
import 'package:medalert/models/medicine_model.dart';
import 'package:medalert/models/reminder_model.dart';
import 'package:medalert/models/time_model.dart';
import 'package:medalert/models/user_model.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/providers/reminder_provider.dart';
import 'package:medalert/providers/user_provider.dart';
import 'package:medalert/screens/forgot_password.dart';
import 'package:medalert/screens/sign_up.dart';
import 'package:medalert/services/notification_services.dart';
import 'package:provider/provider.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formkey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String email = "", password = "";
  bool isLoading = false;

  Future userLogin() async {
    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      final userDetails = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user?.uid)
          .get();

      final medicineDetails = await FirebaseFirestore.instance
          .collection('Users')
          .doc(userCredential.user?.uid)
          .collection('medicines')
          .get();

      print(
        "!!!!!!!!!    Medicine length : ${medicineDetails.docs.length} !!!!!!!!!!!!",
      );
      //Save to hive after fetching from firestore
      final data = userDetails.data();
      if (data != null) {
        final users = UserModel(
          name: data['name'],
          uid: FirebaseAuth.instance.currentUser!.uid,
          profession: data['profession'],
          email: data['email'],
          photoUrl: data['photoUrl'],
        );
        context.read<UserProvider>().saveUserLocal(users);
        print("!!!  User Data fetched from firestore and saved into hive  !!!");
      }

      for (final doc in medicineDetails.docs) {
        final data = doc.data();
        final medicines = MedicineModel(
          id: data["id"],
          name: data['name'],
          desc: data['desc'],
          quantity: data['quantity'],
        );
        context.read<MedicineProvider>().addMedicineToLocal(medicines);
        print(
          "!!! Medicine Data fetched from firestore and saved into hive  !!!",
        );
      }

      for (final medicineDoc in medicineDetails.docs) {
        final reminderSnapshot = await medicineDoc.reference
            .collection('reminders')
            .get();

        for (final reminderDoc in reminderSnapshot.docs) {
          final data = reminderDoc.data();
          final reminder = ReminderModel(
            id: int.parse(reminderDoc.id),
            medicineId: data["medicineID"],
            hour: data['hour'],
            minute: data['minute'],
            days: List<int>.from(data['days']),
            isActive: data['isActive'],
          );

          context.read<ReminderProvider>().addReminderToLocal(reminder);

          final medicine = context.read<MedicineProvider>().findById(
            reminder.medicineId,
          );
          final now = DateTime.now();

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
        }
        print(
          "!!!!!!          Reminder details fetched from firebase and saved to hive and scheduled notifications   !!!!!!!!!!",
        );
      }
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightGreen,
          content: Text(
            "Suceesfully User Logged In",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => BottomNav()),
      );
      return await userCredential;
    } on FirebaseAuthException catch (e) {
      print(e.code);
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(e.code, style: TextStyle(fontWeight: FontWeight.w600)),
        ),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
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
                  text: "Welcome ",
                  style: GoogleFonts.poppins(
                    fontSize: 35,
                    fontWeight: FontWeight.w700,
                  ),
                  children: <InlineSpan>[
                    TextSpan(
                      text: "Back",
                      style: GoogleFonts.poppins(
                        fontSize: 35,
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
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: TextFormField(
                          controller: passwordController,
                          keyboardType: TextInputType.visiblePassword,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter a password";
                            } else
                              return null;
                          },

                          decoration: InputDecoration(
                            labelText: "Password",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassword(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot passoword ?",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
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
                      password = passwordController.text;

                      await userLogin();
                    }
                  },
                  child: isLoading == true
                      ? Container(
                          margin: EdgeInsets.only(top: 2, bottom: 2),

                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 3,
                          ),
                        )
                      : Text(
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
                  "Does'nt have an account ?",
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
