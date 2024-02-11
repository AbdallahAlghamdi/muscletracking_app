import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SuccessfulRegistration extends StatelessWidget {
  const SuccessfulRegistration({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'lib/icons/reactions/successfulRegistration.json',
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/loginPage');
            },
            child: Text("Go back to login page!  😁"),
            style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll(Colors.purple)),
          )
        ],
      )),
    );
  }
}
