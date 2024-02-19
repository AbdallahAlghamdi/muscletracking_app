import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/online/database.dart';

class AlertDurationDialogue extends StatefulWidget {
  final Duration currentDuration;
  final int patientID;
  final String muscleGroup;
  final String durationIndex;
  const AlertDurationDialogue(
      {super.key,
      required this.currentDuration,
      required this.patientID,
      required this.muscleGroup,
      required this.durationIndex});

  @override
  State<AlertDurationDialogue> createState() => _AlertDurationDialogueState();
}

class _AlertDurationDialogueState extends State<AlertDurationDialogue> {
  Duration durationPicker = const Duration();
  @override
  void initState() {
    super.initState();
    durationPicker = widget.currentDuration;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Pick the duration"),
      content: DurationPicker(
          duration: durationPicker,
          onChange: (value) {
            setState(() {
              durationPicker = value;
            });
          }),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // print("New milestone: ${durationPicker.inSeconds}");
            // print("PatientID: ${widget.patientID}");
            // print("MuscleGroup: ${widget.muscleGroup}");
            // print("DurationIndex: ${widget.durationIndex}");
            sendNewMilestone(durationPicker.inSeconds, widget.patientID,
                widget.muscleGroup.toUpperCase(), widget.durationIndex);
            Navigator.pop(context, durationPicker.inSeconds);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
