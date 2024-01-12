import 'package:flutter/material.dart';

class PickTime extends StatefulWidget {
  final String muscleGroup;
  const PickTime({super.key, required this.muscleGroup});

  @override
  State<PickTime> createState() => PickTimeState();
}

class PickTimeState extends State<PickTime> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('data'),
          ],
        ),
      ),
    );
  }
}
