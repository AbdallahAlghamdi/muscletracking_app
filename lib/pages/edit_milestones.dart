import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/milestones/muscle_row_duration.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:muscletracking_app/componets/sliding_buttons.dart';
import 'package:muscletracking_app/utils/patient_progress.dart';

class EditMilestones extends StatefulWidget {
  final int patientID;
  final String patientName;
  const EditMilestones(
      {super.key, required this.patientID, required this.patientName});

  @override
  State<EditMilestones> createState() => _EditMilestonesState();
}

class _EditMilestonesState extends State<EditMilestones> {
  List<int> milestones = [0, 0, 0, 0];
  bool isLoaded = false;
  String durationIndex = 'daily';
  @override
  void initState() {
    super.initState();
    getmilestones();
  }

  getmilestones() async {
    PatientProgress progress = await getPatientSummary(
        widget.patientID, durationIndex[0], widget.patientName);
    print(progress.milestone);
    setState(() {
      milestones = progress.milestone;
      isLoaded = true;
    });
  }

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
            passedFunction: (index) {
              setState(() {
                isLoaded = false;
              });
              switch (index) {
                case 0:
                  durationIndex = 'daily';
                  break;
                case 1:
                  durationIndex = 'weekly';
                  break;
                case 2:
                  durationIndex = 'monthly';
                  break;
                case 3:
                  durationIndex = 'yearly';
                  break;
              }
              getmilestones();
            },
            elements: {
              0: Image.asset('lib/icons/day.png'),
              1: Image.asset('lib/icons/week.png'),
              2: Image.asset('lib/icons/month.png'),
              3: Image.asset('lib/icons/year.png')
            },
          ),
          const SizedBox(height: 25),
          Visibility(
            visible: isLoaded,
            child: Container(
              width: double.infinity,
              height: 350,
              decoration: BoxDecoration(
                  color: Colors.deepPurpleAccent,
                  borderRadius: BorderRadius.circular(10)),
              child: Column(children: [
                const SizedBox(height: 20),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Duration ⏱",
                      style: TextStyle(
                          color: Color.fromARGB(218, 255, 255, 255),
                          fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(height: 5),
                MuscleRowMilestone(
                  duration: milestones[0],
                  muscleGroup: "bicep",
                  patientID: widget.patientID,
                  durationIndex: durationIndex,
                ),
                MuscleRowMilestone(
                  duration: milestones[1],
                  muscleGroup: "calf",
                  patientID: widget.patientID,
                  durationIndex: durationIndex,
                ),
                MuscleRowMilestone(
                  duration: milestones[2],
                  muscleGroup: "thigh",
                  patientID: widget.patientID,
                  durationIndex: durationIndex,
                ),
                MuscleRowMilestone(
                  duration: milestones[3],
                  muscleGroup: "forearm",
                  patientID: widget.patientID,
                  durationIndex: durationIndex,
                ),
              ]),
            ),
          ),
        ]),
      ),
    );
  }
}
