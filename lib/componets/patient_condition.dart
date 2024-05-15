import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:muscletracking_app/componets/alert_pop_up.dart';

class PatientCondition extends StatelessWidget {
  final List<double> data;
  final String patientName;
  final String muscleName;
  final String duration;

  const PatientCondition(
      {super.key,
      required this.data,
      required this.patientName,
      required this.muscleName,
      required this.duration});

  double getCorreCoefficent() {
    List<double> y = data;
    List<double> xy = [];
    List<double> x2 = [];
    List<double> y2 = [];
    double sumX = 0;
    for (int i = 0; i < y.length; i++) {
      xy.add((i + 1) * y[i]);
      x2.add((i + 1) * (i + 1));
      y2.add(y[i] * y[i]);
      sumX += i + 1;
    }
    double sumY = y.sum;
    double sumXY = xy.sum;
    double sumX2 = x2.sum;
    double sumY2 = y2.sum;
    int numberOfElements = y.length;
    var upHalf = ((numberOfElements * sumXY) - (sumX * sumY));
    var bottomHalf = sqrt((numberOfElements * sumX2 - sumX * sumX) *
        (numberOfElements * sumY2 - sumY * sumY));
    var coefficient = upHalf / bottomHalf;
    return coefficient;
  }

  @override
  Widget build(BuildContext context) {
    TextStyle whiteText = const TextStyle(color: Colors.white);
    String animation = "lib/icons/reactions/disappointed.json";
    double getAverage() {
      if (data.length < 2) {
        return 0;
      }
      double average = 0;
      for (int i = 1; i < data.length; i++) {
        average += data[i];
      }
      average = average / (data.length - 1);
      double numerator = average - data[0];
      double denominator = data[0];
      double result = numerator / denominator * 100;
      return result;
    }

    String getCosistencyMessage() {
      if (data.length > 1) {
        double coefficient = getCorreCoefficent();
        if (coefficient > 0.85) {
          animation = "lib/icons/reactions/amazing.json";
          return "Great progress";
        } else if (coefficient > 0.75) {
          animation = "lib/icons/reactions/good.json";
          return "Good progress";
        } else if (coefficient > 0.50) {
          animation = "lib/icons/reactions/disappointed.json";
          return "Inconsistent progress";
        } else {
          animation = "lib/icons/reactions/verydisappointed.json";
          return "Negative progress";
        }
      }
      return "";
    }

    return Visibility(
      visible: data.length > 2,
      replacement: Container(
        margin: const EdgeInsets.only(bottom: 15),
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(8)),
        child: const Text(
          "Not enough data to give a summary.",
          style: TextStyle(color: Colors.white),
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return const AlertPopUp(
                            text: "To find out the consistency of the muscle "
                                "improvement. We the use the Coefficient "
                                "Correlation to compute consistency. The closer "
                                "number to one, the higher consistency.\n\n"
                                "Rate < 0: Bad progress\n"
                                "Rate < 0.5: Mixed progress\n"
                                "Rate < 0.75: Good progress\n"
                                "Rate > 0.80: Great  progress\n",
                            icon: Icon(
                              Icons.info,
                            ),
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.info,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            Text("Patient Name: $patientName", style: whiteText),
            Text("Muscle Name: $muscleName", style: whiteText),
            Text("Duration: $duration", style: whiteText),
            Text("Average Improvement: ${getAverage().toStringAsFixed(2)}%",
                style: whiteText),
            Text(
                "Muscle Consistency: ${getCorreCoefficent().toStringAsFixed(3)}",
                style: whiteText),
            Text(getCosistencyMessage(), style: whiteText),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [Lottie.asset(animation, width: 60)],
            )
          ],
        ),
      ),
    );
  }
}
