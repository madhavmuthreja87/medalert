import 'dart:ui_web';

import 'package:flutter/material.dart';

class TextfieldInput extends StatefulWidget {
  final String text;
  const TextfieldInput({required this.text, super.key});

  @override
  State<TextfieldInput> createState() => _TextfieldInputState();
}

class _TextfieldInputState extends State<TextfieldInput> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
      child: TextField(controller: nameController),
    );
  }
}
