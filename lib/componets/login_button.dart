import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback function;
  const LoginButton({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10),
      child: OutlinedButton(
        onPressed: function,
        style: const ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll(Color.fromARGB(255, 165, 202, 243))),
        child: const Text(
          "Login",
          style: TextStyle(color: Color.fromARGB(255, 116, 114, 114)),
        ),
      ),
    );
  }
}
