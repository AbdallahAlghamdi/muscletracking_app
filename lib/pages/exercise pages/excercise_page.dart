import 'package:flutter/material.dart' hide BoxDecoration, BoxShadow;
import 'package:muscletracking_app/pages/exercise%20pages/bluetooth_check.dart';
import 'package:muscletracking_app/pages/interface/patient_exercise.dart';
import 'package:muscletracking_app/pages/interface/physician_exercise.dart';
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
    return Visibility(
        visible: isLoaded,
        child: isPatient
            ? PatientExercise(function: gotoBluetoothCheck, show: isPatient)
            : const PhysicianExercise());
  }
}
