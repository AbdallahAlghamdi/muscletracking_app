import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PatientCondition extends StatelessWidget {
  final TextStyle style;
  final double avgImprovement = 3.4;
  const PatientCondition({super.key, required this.style});
  String getStatement(double improvement) {
    if (improvement > 0) {
      if (improvement > 15) {
        return "Amazing! Your muscles have grown more than ${improvement.toStringAsFixed(2)}%!";
      }
      if (improvement > 10) {
        return "Great work! you have ${improvement.toStringAsFixed(2)}% increased muscle activity";
      }
      return "Good work! you have ${improvement.toStringAsFixed(2)}% increased muscle activity";
    } else if (improvement < -5) {
      return "Please contact your physician, something is wrong. You had ${improvement.abs().toStringAsFixed(2)}% decrease in muscle mass";
    }
    return "Please exercise more";
  }

  Widget GetReaction(double improvement) {
    if (improvement > 0) {
      if (improvement > 15) {
        return Lottie.asset('lib/icons/reactions/amazing.json', width: 200);
      }
      if (improvement > 10) {
        return Lottie.asset('lib/icons/reactions/verygood.json', width: 200);
      }
      return Lottie.asset('lib/icons/reactions/good.json', width: 200);
    } else if (improvement < -5) {
      return Lottie.asset('lib/icons/reactions/verydisappointed.json',
          width: 200);
    }
    return Lottie.asset('lib/icons/reactions/disappointed.json', width: 200);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 40),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          children: [
            Text(
              getStatement(avgImprovement),
              style: style,
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(10),
              child: GetReaction(avgImprovement),
            )
          ],
        ),
      ),
    );
  }
}
