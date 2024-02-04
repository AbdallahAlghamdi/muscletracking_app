import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailBodyField extends StatelessWidget {
  final bool isVisible;
  final TextEditingController controller;

  const EmailBodyField(
      {super.key, required this.controller, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Expanded(
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
          decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(25)),
          child: TextField(
            inputFormatters: [LengthLimitingTextInputFormatter(65535)],
            controller: controller,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white54))),
            minLines: null,
            maxLines: null,
            expands: true,
          ),
        ),
      ),
    );
  }
}
