import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            margin: EdgeInsets.all(25),
            child: const Text(
              "This app connects to an EMG sensor. But the data it recieves do not correlate with any real life metrics. The sensor can assign a value to an activity exhibited by the muscle, and an increase in percieved acivity correlates to increased muscle mass.",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ]),
      ),
    );
  }
}
