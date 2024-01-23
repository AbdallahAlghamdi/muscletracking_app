import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class PatientCondition extends StatelessWidget {
  final double avgImprovement;
  const PatientCondition({super.key, required this.avgImprovement});
  String getStatement(double improvement) {
    if (improvement > 0) {
      if (improvement > 0.75) {
        improvement = improvement * 100;
        return "Amazing! Your muscles have grown more than ${improvement.toStringAsFixed(2)}%!";
      }
      if (improvement > 0.25) {
        improvement = improvement * 100;
        return "Great work! you have ${improvement.toStringAsFixed(2)}% increased muscle activity";
      }
      return "Good work! you have ${improvement.toStringAsFixed(2)}% increased muscle activity";
    } else if (improvement < -5) {
      return "Missing Data";
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
    return Container(
      width: double.infinity,
      height: 400,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.only(bottom: 40),
      decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          Text(
            getStatement(avgImprovement),
            style: GoogleFonts.abel(fontSize: 20, color: Colors.white),
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(10),
            child: GetReaction(avgImprovement),
          )
        ],
      ),
    );
  }
}
