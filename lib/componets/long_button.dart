import 'package:flutter/material.dart';

class LongButton extends StatelessWidget {
  final VoidCallback function;
  final String buttonText;
  final Color backgroundColor;
  const LongButton(
      {super.key,
      required this.function,
      required this.buttonText,
      required this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: OutlinedButton(
        onPressed: function,
        style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(backgroundColor)),
        child: Text(
          buttonText,
          style: const TextStyle(color: Color.fromARGB(255, 116, 114, 114)),
        ),
      ),
    );
  }
}
