import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MailTitleField extends StatelessWidget {
  final TextEditingController controller;
  final bool isVisible;
  const MailTitleField(
      {super.key, required this.controller, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Container(
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(25)),
            padding: const EdgeInsets.all(25),
            margin: const EdgeInsets.only(left: 25, right: 25, top: 25),
            child: TextField(
              inputFormatters: [LengthLimitingTextInputFormatter(255)],
              style: const TextStyle(color: Colors.white),
              controller: controller,
              decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white54)),
                  hintStyle: const TextStyle(color: Colors.white54),
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2, color: Colors.white),
                      borderRadius: BorderRadius.circular(25 / 2)),
                  hintText: "Enter mail title here",
                  label: const Text(
                    "Mail title",
                    style: TextStyle(color: Colors.white),
                  )),
            )),
      ),
    );
  }
}
