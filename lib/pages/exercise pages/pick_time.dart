import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:muscletracking_app/componets/text_icon.dart';
import 'package:muscletracking_app/pages/exercise%20pages/exercise_session.dart';

class PickTime extends StatefulWidget {
  final String muscleGroup;
  const PickTime({super.key, required this.muscleGroup});

  @override
  State<PickTime> createState() => PickTimeState();
}

Duration exerciseDuration = const Duration();
bool timeSelected = false;

class PickTimeState extends State<PickTime> {
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
          "Pick the time! ⏱",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lib/icons/reactions/picktime.json', width: 300),
            const SizedBox(height: 12),
            DurationPicker(
              baseUnit: BaseUnit.second,
              onChange: (value) {
                setState(() {
                  exerciseDuration = value;
                  if (value.inSeconds > 0) {
                    timeSelected = true;
                  } else {
                    timeSelected = false;
                  }
                });
              },
              duration: exerciseDuration,
            ),
            Visibility(
              visible: timeSelected,
              child: TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.deepPurpleAccent)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ExerciseSession(
                        muscleGroup: widget.muscleGroup,
                        exerciseDuration: exerciseDuration,
                      ),
                    ),
                  );
                },
                child: const Text(
                  'Next',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
