import 'package:flutter/material.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/providers/reminder_provider.dart';
import 'package:medalert/providers/user_provider.dart';
import 'package:medalert/screens/add_medicine.dart';

import 'package:medalert/screens/home_screen.dart';
import 'package:medalert/screens/profile.dart';
import 'package:medalert/screens/sign_up.dart';
import 'package:medalert/services/hive_services.dart';
import 'package:medalert/services/notification_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveServices().init();
  await NotificationServices().initialize();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MedicineProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF8F9FA),
        appBarTheme: AppBarThemeData(backgroundColor: Color(0xFFF8F9FA)),
      ),

      debugShowCheckedModeBanner: false,
      title: 'Med Alert',
      home: UserProvider().box.isEmpty ? SignUp() : BottomNav(),
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  List<Widget> screen = [
    const HomeScreen(),
    const AddMedicine(),
    const Profile(),
  ];
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            index = value;
          });
        },
        elevation: 10,
        type: BottomNavigationBarType.shifting,

        iconSize: 20,
        selectedItemColor: const Color.fromARGB(244, 96, 72, 183),
        unselectedItemColor: Colors.black,
        currentIndex: index,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "add"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profile"),
        ],
      ),
    );
  }
}
