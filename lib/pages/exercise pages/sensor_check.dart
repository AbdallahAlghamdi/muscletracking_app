import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:muscletracking_app/componets/text_icon.dart';
import 'package:muscletracking_app/pages/exercise%20pages/pick_time.dart';
import 'package:muscletracking_app/pages/exercise%20pages/video_page.dart';

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
        return 'lib/icons/calf.png';
      case 'FOREARM':
        return 'lib/icons/forearm.png';
      case 'THIGH':
        return 'lib/icons/thigh.png';
    }
  }

  goToExerciseSession() {}

  String getTitle() {
    String firstCharacter = widget.muscleGroup[0];
    String restOfString = widget.muscleGroup.substring(1).toLowerCase();
    return firstCharacter + restOfString;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          "Exercise:  ${getTitle()}",
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          Image.asset(getImage(), width: 40),
          const SizedBox(width: 20)
        ],
      ),
      body: SafeArea(
          child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
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
                  onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                PickTime(muscleGroup: widget.muscleGroup)),
                      ),
                  child: const Text(
                    'Ready',
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
            ),
            Visibility(
              visible: !isSensorReady,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurpleAccent),
                child: const TextIcon(
                  icon: Icons.help,
                  text: Text(
                    "Do you need help?",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            VideoPage(muscleGroup: widget.muscleGroup)),
                  );
                },
              ),
            ),
            Container(
              margin: const EdgeInsets.all(25),
              child: Lottie.asset(
                  isSensorReady
                      ? "lib/icons/reactions/holding_hands.json"
                      : "lib/icons/reactions/disappointed.json",
                  width: 200),
            ),
          ],
        ),
      )),
    );
  }
}
