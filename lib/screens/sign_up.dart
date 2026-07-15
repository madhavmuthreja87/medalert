import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:medalert/main.dart';
import 'package:medalert/models/user_model.dart';
import 'package:medalert/providers/user_provider.dart';
import 'package:medalert/screens/log_in.dart';

import 'package:provider/provider.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final _formkey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name = "", email = "", password = "";
  Future userRegister() async {
    setState(() {
      isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      print("User created!!!!!!!!!");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.lightGreen,
          content: Text(
            "Successfully Account created",
            style: TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNav()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Weak password",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Email already in use",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
      if (e.code == 'invalid-email') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "Invalid email",
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        );
      }
      print("Error occured");
      print(e.message);
      print(e.code);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      setState(() {
        isLoading = true;
      });
      await _googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } catch (e) {
      print("Google Sign-In Error: $e");
      return null;
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
              SizedBox(height: 80),
              Form(
                key: _formkey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 70,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter your name";
                            } else
                              return null;
                          },
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
                  ],
                ),
              ),

              SizedBox(height: 60),
              OutlinedButton(
                onPressed: () async {
                  await signInWithGoogle();
                  final User = FirebaseAuth.instance.currentUser;
                  if (User != null) {
                    setState(() {
                      name = User.displayName!;
                      email = User.email!;
                    });
                  }

                  final user = UserModel(
                    email: email,
                    name: name,
                    photoUrl: "klln",
                    profession: "",
                    uid: User?.uid ?? "Uid",
                  );
                  context.read<UserProvider>().saveUser(user);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => const BottomNav()),
                  );
                  print(User?.displayName);
                },
                child: Container(
                  height: 40,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.network(
                        height: 30,
                        "https://tse4.mm.bing.net/th/id/OIP.Lx_8Mg6rEyd7aBoGv7QiZgHaHa?r=0&w=1000&h=1000&rs=1&pid=ImgDetMain&o=7&rm=3",
                      ),
                      SizedBox(width: 40),
                      isLoading == true
                          ? Container(
                              margin: EdgeInsets.only(top: 2, bottom: 2),

                              child: CircularProgressIndicator(strokeWidth: 3),
                            )
                          : Text("Sign in with Google"),
                    ],
                  ),
                ),
              ),
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
                      name = nameController.text;
                      email = emailController.text;
                      password = passwordController.text;

                      await userRegister();
                      final credential = FirebaseAuth.instance.currentUser;

                      final user = UserModel(
                        email: emailController.text,
                        name: nameController.text,
                        photoUrl: "cvs",
                        profession: passwordController.text,
                        uid: credential?.uid ?? "Uid",
                      );
                      context.read<UserProvider>().saveUser(user);
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
              SizedBox(height: 30),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => LogIn()),
                  );
                },
                child: Text(
                  "Already have an account ?",
                  style: TextStyle(fontSize: 17),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
