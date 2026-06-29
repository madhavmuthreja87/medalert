import 'package:flutter/material.dart';

class MedicineCard extends StatefulWidget {
  final String name, desc;
  const MedicineCard({required this.name, required this.desc, super.key});

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height / 7,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color.fromARGB(130, 226, 165, 165),
          borderRadius: BorderRadius.circular(30),
        ),
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 14, color: Colors.grey),
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
                        "${widget.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: .start,
                    children: [Text("${widget.desc}")],
                  ),
                ],
              ),
              CircleAvatar(
                maxRadius: 25,
                backgroundColor: Colors.transparent,
                child: Image.network(
                  "https://cdn-icons-png.flaticon.com/512/8638/8638176.png",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
