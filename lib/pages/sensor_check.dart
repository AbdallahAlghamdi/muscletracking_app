import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/pages/exercise_session.dart';
import 'package:lottie/lottie.dart';

import 'package:muscletracking_app/pages/pick_time.dart';

class SensorCheck extends StatefulWidget {
  final String muscleGroup;
  const SensorCheck({super.key, required this.muscleGroup});

  @override
  State<SensorCheck> createState() => _SensorCheckState();
}

bool isSensorReady = false;

class _SensorCheckState extends State<SensorCheck> {
  getImage() {
    switch (widget.muscleGroup) {
      case 'BICEP':
        return 'lib/icons/bicep.png';
      case 'CALF':
        return 'lib/icons/leg.png';
      case 'FOREARM':
        return 'lib/icons/forearm.png';
      case 'QUAD':
        return 'lib/icons/quad.png';
    }
  }

  goToExerciseSession() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Exercise:  ${widget.muscleGroup.toLowerCase()}"),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          Image.asset(getImage(), width: 40),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      body: SafeArea(
          child: Container(
        margin: EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              'Before exercise can begin, we have to check the sensor.',
              style: GoogleFonts.abel(fontSize: 24),
            ),
            const SizedBox(height: 20),
            TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll<Color>(
                        Colors.deepPurpleAccent)),
                onPressed: () {
                  setState(() {
                    isSensorReady = true;
                  });
                },
                child: const Text(
                  'Sensor signal is noise-free',
                  style: TextStyle(color: Colors.white, fontSize: 17),
                )),
            TextButton(
              style: const ButtonStyle(
                  backgroundColor:
                      MaterialStatePropertyAll<Color>(Colors.deepPurpleAccent)),
              onPressed: () {
                setState(() {
                  isSensorReady = false;
                });
              },
              child: const Text(
                'Sensor signal is noisy',
                style: TextStyle(color: Colors.white, fontSize: 17),
              ),
            ),
            Visibility(
              visible: isSensorReady,
              child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.deepPurpleAccent)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              PickTime(muscleGroup: widget.muscleGroup)),
                    );
                  },
                  child: const Text(
                    'Ready',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
            ),
            SizedBox(
              height: 40,
            ),
            Visibility(
                visible: isSensorReady,
                child: Lottie.asset('lib/icons/reactions/holding_hands.json',
                    width: 250))
          ],
        ),
      )),
    );
  }
}
