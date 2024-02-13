import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
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
  Duration timePickerDuration = Duration(seconds: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.patientName,
          style: TextStyle(color: Colors.white),
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
            child: Column(children: [
              SizedBox(height: 20),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Duration ⏱",
                    style: TextStyle(color: Color.fromARGB(218, 255, 255, 255)),
                  )
                ],
              ),
              const SizedBox(height: 5),
              MuscleRowMilestone(
                duration: 10000,
                muscleGroup: "bicep",
                timePickerDuration: timePickerDuration,
              ),
              MuscleRowMilestone(
                duration: 5000,
                muscleGroup: "forearm",
                timePickerDuration: timePickerDuration,
              ),
              MuscleRowMilestone(
                duration: 4000,
                muscleGroup: "leg",
                timePickerDuration: timePickerDuration,
              ),
              MuscleRowMilestone(
                duration: 2040,
                muscleGroup: "quad",
                timePickerDuration: timePickerDuration,
              ),
            ]),
          )
        ]),
      ),
    );
  }
}


class MuscleRowMilestone extends StatelessWidget {
  final int duration;
  final String muscleGroup;
  final Duration timePickerDuration;
  const MuscleRowMilestone(
      {super.key,
      required this.duration,
      required this.muscleGroup,
      required this.timePickerDuration});

  @override
  Widget build(BuildContext context) {
    Duration time = Duration(seconds: duration);
    getFormattedTime(Duration time) {
      if (time.inMinutes > 59) {
        return time.toString().substring(0, 7);
      } else {
        return time.toString().substring(2, 7);
      }
    }

    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, bottom: 5, top: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 3, color: const Color.fromARGB(255, 59, 59, 59)),
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 177, 176, 174)),
          padding: const EdgeInsets.all(5),
          child: Image.asset(
            "lib/icons/$muscleGroup.png",
            width: 45,
          ),
        ),
        Container(
          width: 150,
          height: 60,
          margin: const EdgeInsets.only(left: 15),
          padding: const EdgeInsets.only(left: 5),
          decoration: BoxDecoration(
              border: Border.all(
                  width: 3, color: const Color.fromARGB(255, 59, 59, 59)),
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 202, 200, 196)),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              getFormattedTime(time),
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ),
        ),
        const SizedBox(width: 15),
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
            showModalBottomSheet(
                context: context,
                enableDrag: false,
                builder: (BuildContext context) {
                  return Container(
                    height: 400,
                    width: double.infinity,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        DurationPicker(
                          duration: timePickerDuration,
                          onChange: (value) {
                            timePickerDuration = value;
                          },
                        ),
                      ],
                    ),
                  );
                });
          },
          icon: const Icon(
            UniconsLine.stopwatch,
            size: 28,
            color: Colors.black54,
          ),
        )
      ],
    );
  }
}
