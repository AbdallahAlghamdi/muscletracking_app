import 'package:flutter/material.dart';

class BluetoothList extends StatelessWidget {
  final ListView list;
  const BluetoothList({super.key, required this.list});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      width: 300,
      decoration: BoxDecoration(
          color: Colors.deepPurple, borderRadius: BorderRadius.circular(10)),
      child: list,
    );
  }
}
