import 'package:flutter/material.dart';
import 'dart:math';

import 'package:medalert/providers/medicine_provider.dart';
import 'package:provider/provider.dart';

class MedicineCard extends StatefulWidget {
  final String name, desc;
  final int id, quantity;
  const MedicineCard({
    required this.name,
    required this.desc,
    required this.id,
    required this.quantity,
    super.key,
  });

  @override
  State<MedicineCard> createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  List<Color> color = [
    const Color(0xFFE8F8F1),
    const Color(0xFFFFE5E5),
    const Color(0xFFFFF0E5),
    const Color(0xFFE6F0E8),
    const Color.fromARGB(255, 217, 206, 248),
    const Color(0xFFEAF7FF),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0, horizontal: 8),
      child: Container(
        width: double.infinity,
        height: MediaQuery.sizeOf(context).height / 9,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: color[Random().nextInt(6)],
          borderRadius: BorderRadius.circular(20),
        ),
        child: DefaultTextStyle(
          style: TextStyle(fontSize: 14, color: Colors.grey),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text("${widget.desc}")],
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Text("X"),
                          Text(
                            " ${widget.quantity}",
                            style: TextStyle(fontSize: 27.5),
                          ),
                        ],
                      ),

                      SizedBox(width: 20),
                      CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: Colors.transparent,
                        child: Image.network(
                          "https://cdn-icons-png.flaticon.com/512/8638/8638176.png",
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<MedicineProvider>().deleteMedicine(
                            widget.id,
                          );
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
