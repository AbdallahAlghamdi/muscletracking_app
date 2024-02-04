import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessfulExercise extends StatefulWidget {
  const SuccessfulExercise({super.key});

  @override
  State<SuccessfulExercise> createState() => _SuccessfulExerciseState();
}

class _SuccessfulExerciseState extends State<SuccessfulExercise> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 5), () {
      Navigator.pushReplacementNamed(context, '/frontPage');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("✨"),
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Lottie.asset('lib/icons/reactions/paper_message.json')],
        ),
      ),
    );
  }
}
