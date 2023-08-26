import 'package:flutter/material.dart';
import 'package:muscletracking_app/Components/sliding_buttons.dart';
import 'package:chart_sparkline/chart_sparkline.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  String muscleSelectedGroup = "Bicep";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(height: 20),
        const Text('Select muscle group'),
        const SizedBox(height: 20),
        SlidingButtons(passedFunction: (int index) {
          switch (index) {
            case 0:
              muscleSelectedGroup = "Bicep";
              break;
            case 1:
              muscleSelectedGroup = "Calf";
              break;
            case 2:
              muscleSelectedGroup = "Forearm";
              break;
            case 3:
              muscleSelectedGroup = "Thigh";
              break;
          }
          setState(() {
            muscleSelectedGroup;
          });
        }),
        const SizedBox(height: 20),
        Text(muscleSelectedGroup),
        const SizedBox(height: 20),
        SizedBox(
            width: 250.0,
            height: 100.0,
            child: Sparkline(
              pointsMode: PointsMode.all,
              data: data,
              averageLine: true,
              useCubicSmoothing: true,
              cubicSmoothingFactor: 0.2,
              enableGridLines: true,
            ))
      ]),
    );
  }
}
