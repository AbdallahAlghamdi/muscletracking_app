import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:unicons/unicons.dart';

class TextFieldAdd extends StatelessWidget {
  final Function(String) function;
  const TextFieldAdd({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.deepPurple),
        borderRadius: BorderRadius.circular(20),
      ),
      width: 200,
      padding: const EdgeInsets.only(left: 10),
      child: TextField(
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
          FilteringTextInputFormatter.digitsOnly
        ],
        onSubmitted: function,
        decoration: InputDecoration(
          hintText: "Patient ID",
          prefix: Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(UniconsLine.user_square),
          ),
        ),
      ),
    );
  }
}
