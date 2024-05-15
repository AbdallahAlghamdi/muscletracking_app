import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class ToggleButtonMail extends StatelessWidget {
  final String isOutBound; //String of the status of the button
  final Function(Set<String>)
      function; //function called when the user presses a button in the toggle
  const ToggleButtonMail(
      {super.key, required this.isOutBound, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, //takes all possible width
      margin: const EdgeInsets.all(25), //adds margin
      child: SegmentedButton<String>(
          emptySelectionAllowed:
              false, // allows for neither option to be picked
          style: TextButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            disabledBackgroundColor: Colors.grey,
          ),
          selectedIcon: const Icon(
            UniconsLine.arrow_right,
            color: Colors.white,
            size: 25,
          ),
          segments: const [
            ButtonSegment(
                value: "inbox",
                label: Text("Inbox", style: TextStyle(color: Colors.white))),
            ButtonSegment(
                value: "sent",
                label: Text("Sent", style: TextStyle(color: Colors.white)))
          ],
          selected: <String>{isOutBound},
          onSelectionChanged: function),
    );
  }
}
