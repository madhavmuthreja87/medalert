import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/screens/add_medicine.dart';

import 'package:medalert/screens/home_screen.dart';
import 'package:medalert/screens/profile.dart';
import 'package:medalert/services/hive_services.dart';
import 'package:medalert/services/notification_services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveServices().init();
  await NotificationServices().initialize();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MedicineProvider())],

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
      debugShowCheckedModeBanner: false,
      title: 'Med Alert',
      home: const BottomNav(),
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
