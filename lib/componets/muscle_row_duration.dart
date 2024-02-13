import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/alert_duration_dialogue.dart';
import 'package:unicons/unicons.dart';

class MuscleRowMilestone extends StatefulWidget {
  final int duration;
  final String muscleGroup;
  const MuscleRowMilestone({
    super.key,
    required this.duration,
    required this.muscleGroup,
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
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 15, bottom: 5, top: 5),
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
          width: 150,
          height: 60,
          margin: const EdgeInsets.only(left: 15),
          padding: const EdgeInsets.only(left: 5),
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
            showDialog(
                context: context,
                barrierLabel: "TEST",
                builder: (context) => const AlertDurationDialogue());
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
