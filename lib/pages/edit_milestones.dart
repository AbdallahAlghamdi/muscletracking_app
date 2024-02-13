import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/muscle_row_duration.dart';
import 'package:muscletracking_app/componets/sliding_buttons.dart';
import 'package:unicons/unicons.dart';

class EditMilestones extends StatefulWidget {
  final int patientID;
  final String patientName;
  const EditMilestones(
      {super.key, required this.patientID, required this.patientName});

  @override
  State<EditMilestones> createState() => _EditMilestonesState();
}

class _EditMilestonesState extends State<EditMilestones> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.patientName,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Column(children: [
          SlidingButtons(
            passedFunction: (index) {},
            elements: {
              0: Image.asset('lib/icons/day.png'),
              1: Image.asset('lib/icons/week.png'),
              2: Image.asset('lib/icons/month.png'),
              3: Image.asset('lib/icons/year.png')
            },
          ),
          const SizedBox(height: 25),
          Container(
            width: double.infinity,
            height: 350,
            decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                borderRadius: BorderRadius.circular(10)),
            child: const Column(children: [
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Duration ⏱",
                    style: TextStyle(color: Color.fromARGB(218, 255, 255, 255)),
                  )
                ],
              ),
              SizedBox(height: 5),
              MuscleRowMilestone(
                duration: 10000,
                muscleGroup: "bicep",
              ),
              MuscleRowMilestone(
                duration: 5000,
                muscleGroup: "forearm",
              ),
              MuscleRowMilestone(
                duration: 4000,
                muscleGroup: "leg",
              ),
              MuscleRowMilestone(
                duration: 2040,
                muscleGroup: "quad",
              ),
            ]),
          ),
        ]),
      ),
    );
  }
}
