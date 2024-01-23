import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessfulExercise extends StatelessWidget {
  const SuccessfulExercise({super.key});

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
