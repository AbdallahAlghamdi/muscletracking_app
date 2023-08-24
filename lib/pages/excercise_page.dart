import 'package:flutter/material.dart';
import 'package:muscletracking_app/Components/Buttons/image_button.dart';
import 'package:muscletracking_app/pages/excercises/excercise_calf.dart';

class ExcercisePage extends StatefulWidget {
  const ExcercisePage({super.key});

  @override
  State<ExcercisePage> createState() => _ExcercisePageState();
}

class _ExcercisePageState extends State<ExcercisePage> {
  void funcS() {}
  void gotoCalf() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExcerciseCalf()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('"Select the muscle group you want to excercise"'),
        Wrap(
          spacing: 10,
          children: [
            ImageButtonA(
                imageSrc: 'lib/images/biceps.png', functionPassed: gotoCalf),
            ImageButtonA(
              imageSrc: 'lib/images/calf.png',
              functionPassed: funcS,
            ),
            ImageButtonA(
              imageSrc: 'lib/images/forearm.png',
              functionPassed: funcS,
            ),
            ImageButtonA(
              imageSrc: 'lib/images/quad.png',
              functionPassed: funcS,
            ),
          ],
        ),
      ],
    );
  }
}
