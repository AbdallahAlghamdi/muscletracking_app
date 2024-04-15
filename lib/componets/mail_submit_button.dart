import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class MailSubmitButton extends StatelessWidget {
  final VoidCallback function;
  final bool isVisible;

  const MailSubmitButton(
      {super.key, required this.function, required this.isVisible});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
        margin: const EdgeInsets.all(25),
        child: ElevatedButton(
          onPressed: function,
          style: const ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.deepPurple)),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Send', style: TextStyle(color: Colors.white)),
              SizedBox(
                width: 10,
              ),
              Icon(UniconsLine.envelope_send, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
