import 'package:flutter/material.dart';

class AlertPopUp extends StatelessWidget {
  final String text;
  final Icon icon;
  final Widget? content;
  const AlertPopUp(
      {super.key, required this.text, required this.icon, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
      icon: icon,
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
