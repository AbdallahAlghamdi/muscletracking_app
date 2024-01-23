import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:muscletracking_app/componets/Buttons/image_button.dart';
import 'package:muscletracking_app/pages/exercise%20pages/bluetooth_check.dart';
import 'package:muscletracking_app/utils/colors.dart';

class ExcercisePage extends StatefulWidget {
  const ExcercisePage({super.key});

  @override
  State<ExcercisePage> createState() => _ExcercisePageState();
}

class _ExcercisePageState extends State<ExcercisePage> {
  funcS() {}
  gotoCalf() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const BluetoothCheck(muscleGroup: 'CALF')),
    );
  }

  gotoBicep() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const BluetoothCheck(muscleGroup: 'BICEP')),
    );
  }

  gotoQuad() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const BluetoothCheck(muscleGroup: 'QUAD')),
    );
  }

  gotoForearm() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => const BluetoothCheck(muscleGroup: 'FOREARM')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20)),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, -5),
                      blurRadius: 0,
                      color: Color.fromARGB(255, 55, 23, 110),
                      inset: true),
                ]),
            height: 200,
            width: double.infinity,
            alignment: Alignment.center,
            child: Text(
              "Please select muscle group",
              style: GoogleFonts.abel(fontSize: 27, color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
              top: 120,
              bottom: 0,
              right: 0,
              left: 0,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: ImageButtonA(
                        imageSrc: 'lib/images/biceps.png',
                        functionPassed: gotoBicep),
                  ),
                  Align(
                      alignment: Alignment.center,
                      child: ImageButtonA(
                        imageSrc: 'lib/images/calf.png',
                        functionPassed: gotoCalf,
                      )),
                  Align(
                    alignment: Alignment.center,
                    child: ImageButtonA(
                      imageSrc: 'lib/images/forearm.png',
                      functionPassed: gotoForearm,
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: ImageButtonA(
                      imageSrc: 'lib/images/quad.png',
                      functionPassed: gotoQuad,
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
    // return Column(
    //   mainAxisAlignment: MainAxisAlignment.center,
    //   children: [
    //     const Text(
    //       'Select the muscle group you want to excercise',
    //       style: TextStyle(fontSize: 29),
    //       textAlign: TextAlign.center,
    //     ),
    //     Container(
    //       margin: const EdgeInsets.only(top: 30),
    //       child: Wrap(
    //         children: [
    //           ImageButtonA(
    //               imageSrc: 'lib/images/biceps.png', functionPassed: gotoBicep),
    //           ImageButtonA(
    //             imageSrc: 'lib/images/calf.png',
    //             functionPassed: gotoCalf,
    //           ),
    //           ImageButtonA(
    //             imageSrc: 'lib/images/forearm.png',
    //             functionPassed: gotoForearm,
    //           ),
    //           ImageButtonA(
    //             imageSrc: 'lib/images/quad.png',
    //             functionPassed: gotoQuad,
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }
}


// ListView(scrollDirection: Axis.vertical, children: [
//               ImageButtonA(
//                   imageSrc: 'lib/images/biceps.png', functionPassed: gotoBicep),
//               ImageButtonA(
//                 imageSrc: 'lib/images/calf.png',
//                 functionPassed: gotoCalf,
//               ),
//               ImageButtonA(
//                 imageSrc: 'lib/images/forearm.png',
//                 functionPassed: gotoForearm,
//               ),
//               ImageButtonA(
//                 imageSrc: 'lib/images/quad.png',
//                 functionPassed: gotoQuad,
//               ),
//             ]