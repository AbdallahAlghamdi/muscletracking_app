import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/milestones/alert_duration_dialogue.dart';
import 'package:unicons/unicons.dart';

class MuscleRowMilestone extends StatefulWidget {
  final int duration;
  final String muscleGroup;
  final int patientID;
  final String durationIndex;
  const MuscleRowMilestone({
    super.key,
    required this.duration,
    required this.muscleGroup,
    required this.patientID,
    required this.durationIndex,
  });

  @override
  State<MuscleRowMilestone> createState() => _MuscleRowMilestoneState();
}

class _MuscleRowMilestoneState extends State<MuscleRowMilestone> {
  Duration time = const Duration();

  getFormattedTime(Duration time) {
    if (time.inMinutes > 59) {
      return time.toString().substring(0, 7);
    } else {
      return time.toString().substring(2, 7);
    }
  }

  @override
  void initState() {
    super.initState();
    time = Duration(seconds: widget.duration);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 15, right: 10, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    width: 3, color: const Color.fromARGB(255, 59, 59, 59)),
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 177, 176, 174)),
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              "lib/icons/${widget.muscleGroup}.png",
              width: 45,
            ),
          ),
          Container(
            width: 120,
            height: 60,
            decoration: BoxDecoration(
                border: Border.all(
                    width: 3, color: const Color.fromARGB(255, 59, 59, 59)),
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 202, 200, 196)),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                getFormattedTime(time),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ),
          ),
          IconButton(
            style: const ButtonStyle(
              padding: MaterialStatePropertyAll(EdgeInsets.all(17)),
              backgroundColor:
                  MaterialStatePropertyAll(Color.fromARGB(255, 175, 174, 171)),
              side: MaterialStatePropertyAll(
                BorderSide(width: 3, color: Color.fromARGB(255, 59, 59, 59)),
              ),
            ),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) => AlertDurationDialogue(
                        currentDuration: time,
                        patientID: widget.patientID,
                        muscleGroup: widget.muscleGroup,
                        durationIndex: widget.durationIndex,
                      )).then((value) {
                if (value.toString() != "Cancel" || value == null) {
                  setState(() {
                    time = Duration(seconds: value);
                  });
                }
              });
            },
            icon: const Icon(
              UniconsLine.stopwatch,
              size: 28,
              color: Colors.black54,
            ),
          )
        ],
      ),
    );
  }
}
