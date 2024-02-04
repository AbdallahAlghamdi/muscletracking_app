import 'package:flutter/material.dart';

class ErrorBox extends StatelessWidget {
  final String warningMessage;
  final bool show;
  const ErrorBox({super.key, required this.warningMessage, required this.show});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: Colors.redAccent, width: 2, style: BorderStyle.solid)),
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(
              Icons.warning_amber_rounded,
              color: Colors.red,
              size: 28,
            ),
            const SizedBox(width: 10),
            Text(
              warningMessage,
              style: const TextStyle(color: Colors.red, fontSize: 17),
            ),
          ],
        ),
      ),
    );
  }
}
