import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';
import 'package:muscletracking_app/componets/Buttons/image_button.dart';
import 'package:muscletracking_app/pages/exercise%20pages/bluetooth_check.dart';
import 'package:muscletracking_app/pages/interface/patient_exercise.dart';
import 'package:muscletracking_app/pages/interface/physician_exercise.dart';
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
  gotoBluetoothCheck(String muscleName) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => BluetoothCheck(muscleGroup: muscleName)),
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
    super.initState();
    getAccountType();
  }

  @override
  Widget build(BuildContext context) {
    return isPatient
        ? PatientExercise(function: gotoBluetoothCheck, show: isPatient)
        : PhysicianExercise();
  }
}
