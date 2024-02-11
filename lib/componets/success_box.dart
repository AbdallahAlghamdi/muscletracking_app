import 'package:flutter/material.dart';

class SuccessBox extends StatelessWidget {
  final String sucesssMessage;
  final bool show;
  const SuccessBox(
      {super.key, required this.sucesssMessage, required this.show});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
                color: const Color.fromARGB(255, 16, 77, 189),
                width: 2,
                style: BorderStyle.solid)),
        margin: const EdgeInsets.only(left: 20, right: 20),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(
              Icons.check,
              color: Color.fromARGB(255, 16, 77, 189),
              size: 28,
            ),
            const SizedBox(width: 10),
            Text(
              sucesssMessage,
              style: const TextStyle(
                  color: Color.fromARGB(255, 16, 77, 189), fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
