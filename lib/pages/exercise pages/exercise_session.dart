import 'dart:math';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/alert_pop_up.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:muscletracking_app/pages/exercise%20pages/pick_time.dart';
import 'package:unicons/unicons.dart';

class ExerciseSession extends StatefulWidget {
  final int patientID;
  final String muscleGroup;
  final Duration exerciseDuration;
  const ExerciseSession(
      {super.key,
      required this.muscleGroup,
      required this.exerciseDuration,
      required this.patientID});

  @override
  State<ExerciseSession> createState() => _ExerciseSessionState();
}

var timeController = CountDownController();

class _ExerciseSessionState extends State<ExerciseSession> {
  double getAverage(List<int> list) {
    int totalAmount = 0;
    for (var i = 0; i < list.length; i++) {
      totalAmount += list[i];
    }
    return totalAmount / list.length;
  }

  void simulateData(List<int> list) {
    var randomizer = Random();
    for (var i = 0; i < 10; i++) {
      list.add(randomizer.nextInt(400) + 200);
    }
  }

  void getValueFromArduino() {
    List<int> dataFromArduino = [];
    simulateData(dataFromArduino);
    newExercise(widget.patientID, getAverage(dataFromArduino),
        widget.muscleGroup, dataFromArduino, widget.exerciseDuration.inSeconds);
  }

  void goBackToHomePage() {
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
    Navigator.pop(context);
  }

  void successfulExercisePopup() async {
    goBackToHomePage();
    await showDialog(
        context: context,
        builder: (context) {
          return const AlertPopUp(
            text: "Exercise is done\nGood job!",
            icon: Icon(UniconsLine.smile),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          "Time to exercise! 🏋️‍♂️",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularCountDownTimer(
              onComplete: successfulExercisePopup,
              autoStart: false,
              controller: timeController,
              width: 400,
              height: 200,
              strokeWidth: 20,
              isReverse: true,
              strokeCap: StrokeCap.round,
              textStyle: const TextStyle(color: Colors.white, fontSize: 27),
              duration: exerciseDuration.inSeconds,
              fillColor: Colors.deepPurple,
              ringColor: Colors.deepPurpleAccent,
              backgroundColor: const Color.fromARGB(255, 59, 32, 105),
            ),
            ElevatedButton(
                onPressed: () {
                  getValueFromArduino();
                  if (!timeController.isStarted) {
                    setState(() {
                      timeController.start();
                    });
                  }
                },
                child: const Text('Start')),
          ],
        ),
      ),
    );
  }
}
