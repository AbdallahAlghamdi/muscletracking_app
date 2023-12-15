import 'package:flutter/material.dart';

class ExerciseSession extends StatefulWidget {
  final String muscleGroup;
  const ExerciseSession({super.key, required this.muscleGroup});

  @override
  State<ExerciseSession> createState() => _ExerciseSessionState();
}

class _ExerciseSessionState extends State<ExerciseSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Text(widget.muscleGroup)],
      ),
    );
  }
}
