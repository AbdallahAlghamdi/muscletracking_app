import 'package:duration_picker/duration_picker.dart';
import 'package:flutter/material.dart';

class AlertDurationDialogue extends StatefulWidget {
  const AlertDurationDialogue({super.key});

  @override
  State<AlertDurationDialogue> createState() => _AlertDurationDialogueState();
}

class _AlertDurationDialogueState extends State<AlertDurationDialogue> {
  Duration durationPicker = const Duration();
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
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}
