import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:muscletracking_app/componets/Buttons/image_button.dart';
import 'package:muscletracking_app/pages/exercise%20pages/bluetooth_check.dart';
import 'package:muscletracking_app/utils/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExcercisePage extends StatefulWidget {
  const ExcercisePage({super.key});

  @override
  State<ExcercisePage> createState() => _ExcercisePageState();
}

class _ExcercisePageState extends State<ExcercisePage> {
  bool isLoaded = false;
  bool isPatient = true;
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

  getAccountType() async {
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();

    String accountType = userPreferences.get('account_type').toString();
    setState(() {
      isLoaded = true;
      if (accountType == "patient") {
        isPatient = true;
      } else {
        isPatient = false;
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAccountType();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoaded && isPatient,
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
      ),
    );
  }
}
