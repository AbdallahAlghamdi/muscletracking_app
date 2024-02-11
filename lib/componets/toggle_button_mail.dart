import 'package:flutter/material.dart';

class ToggleButtonMail extends StatelessWidget {
  final String isOutBound;
  final Function(Set<String>) function;
  const ToggleButtonMail(
      {super.key, required this.isOutBound, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(25),
      child: SegmentedButton<String>(
          emptySelectionAllowed: true,
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            disabledIconColor: Colors.grey,
          ),
          selectedIcon: const Icon(Icons.abc, color: Colors.transparent),
          segments: const [
            ButtonSegment(value: "inbox", label: Text("Inbox")),
            ButtonSegment(value: "sent", label: Text("Sent"))
          ],
          selected: <String>{isOutBound},
          onSelectionChanged: function),
    );
  }
}
