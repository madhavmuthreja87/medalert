import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:medalert/models/medicine_model.dart';
import 'package:medalert/providers/medicine_provider.dart';
import 'package:medalert/providers/reminder_provider.dart';
import 'package:medalert/widgets/medicine_card.dart';
import 'package:provider/provider.dart';

class FullStore extends StatefulWidget {
  const FullStore({super.key});

  @override
  State<FullStore> createState() => _FullStoreState();
}

class _FullStoreState extends State<FullStore> {
  @override
  Widget build(BuildContext context) {
    final medicine = context.watch<MedicineProvider>().medicines;
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
          child: ListView.builder(
            itemCount: medicine.length,
            itemBuilder: (context, index) {
              return MedicineCard(
                name: medicine[index].name,
                desc: medicine[index].desc,
                medicineId: medicine[index].id,
                quantity: medicine[index].quantity,
              );
            },
          ),
        ),
      ),
    );
  }
}
