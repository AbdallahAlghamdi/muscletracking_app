import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:muscletracking_app/componets/Buttons/image_button.dart';
import 'package:muscletracking_app/utils/colors.dart';

class PatientExercise extends StatelessWidget {
  final bool show;
  final int patientID;
  final Function(String, int) function;
  const PatientExercise(
      {super.key,
      required this.show,
      required this.patientID,
      required this.function});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: show,
      child: SizedBox(
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
                          functionPassed: () {
                            function("BICEP", patientID);
                          }),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: ImageButtonA(
                          imageSrc: 'lib/images/calf.png',
                          functionPassed: () {
                            function('CALF', patientID);
                          },
                        )),
                    Align(
                      alignment: Alignment.center,
                      child: ImageButtonA(
                        imageSrc: 'lib/images/forearm.png',
                        functionPassed: () {
                          function('FOREARM', patientID);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ImageButtonA(
                        imageSrc: 'lib/images/quad.png',
                        functionPassed: () {
                          function('THIGH', patientID);
                        },
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
