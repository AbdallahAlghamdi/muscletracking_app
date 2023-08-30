import 'package:flutter/material.dart';
import 'package:muscletracking_app/Components/Buttons/image_button.dart';
import 'package:muscletracking_app/pages/excercises/excercise_calf.dart';
import 'package:muscletracking_app/pages/excercises/excercise_bicep.dart';
import 'package:muscletracking_app/pages/excercises/excercise_quad.dart';
import 'package:muscletracking_app/pages/excercises/excercise_forearm.dart';

class ExcercisePage extends StatefulWidget {
  const ExcercisePage({super.key});

  @override
  State<ExcercisePage> createState() => _ExcercisePageState();
}

class _ExcercisePageState extends State<ExcercisePage> {
  funcS() {}
  gotoCalf() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExcerciseCalf()),
    );
  }

  gotoBicep() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExcerciseBicep()),
    );
  }

  gotoQuad() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExcerciseQuad()),
    );
  }

  gotoForearm() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExcerciseForearm()),
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
                imageSrc: 'lib/images/biceps.png', functionPassed: gotoBicep),
            ImageButtonA(
              imageSrc: 'lib/images/calf.png',
              functionPassed: gotoCalf,
            ),
            ImageButtonA(
              imageSrc: 'lib/images/forearm.png',
              functionPassed: gotoForearm,
            ),
            ImageButtonA(
              imageSrc: 'lib/images/quad.png',
              functionPassed: gotoQuad,
            ),
          ],
        ),
      ],
    );
  }
}
