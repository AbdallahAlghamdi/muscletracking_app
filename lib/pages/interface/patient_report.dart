import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/patient_condition.dart';
import 'package:muscletracking_app/componets/sliding_buttons.dart';

class PatientReport extends StatefulWidget {
  final Function(int) slidingMuscleButtons;
  final Function(int) slidingDurationButtons;
  final double avgImprovement;
  const PatientReport(
      {super.key,
      required this.slidingMuscleButtons,
      required this.slidingDurationButtons,
      required this.avgImprovement});

  @override
  State<PatientReport> createState() => _PatientReportState();
}

class _PatientReportState extends State<PatientReport> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Select Muscle',
          style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
      const SizedBox(height: 20),
      SlidingButtons(
        passedFunction: widget.slidingMuscleButtons,
        elements: {
          0: Image.asset('lib/icons/bicep.png'),
          1: Image.asset('lib/icons/leg.png'),
          2: Image.asset('lib/icons/forearm.png'),
          3: Image.asset('lib/icons/quad.png')
        },
      ),
      const SizedBox(height: 20),
      SlidingButtons(
        passedFunction: widget.slidingDurationButtons,
        elements: {
          0: Image.asset('lib/icons/day.png'),
          1: Image.asset('lib/icons/week.png'),
          2: Image.asset('lib/icons/month.png'),
          3: Image.asset('lib/icons/year.png')
        },
      ),
      const SizedBox(height: 20),
      PatientCondition(avgImprovement: widget.avgImprovement)
    ]);
  }
}
