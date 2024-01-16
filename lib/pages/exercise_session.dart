import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muscletracking_app/pages/pick_time.dart';
import 'package:muscletracking_app/pages/successful_exercise.dart';

class ExerciseSession extends StatefulWidget {
  final String muscleGroup;
  final Duration exerciseDuration;
  const ExerciseSession(
      {super.key, required this.muscleGroup, required this.exerciseDuration});

  @override
  State<ExerciseSession> createState() => _ExerciseSessionState();
}

var timeController = CountDownController();

class _ExerciseSessionState extends State<ExerciseSession> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
              onComplete: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const SuccessfulExercise()),
              ),
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
