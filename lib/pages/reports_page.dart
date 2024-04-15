import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:muscletracking_app/pages/interface/patient_report.dart';
import 'package:muscletracking_app/pages/interface/physician_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  //-------------Variables----------
  int patientID = 0;
  int doctorID = 0;
  bool isPatient = true;
  bool isloaded = false;
  String patientName = "";
  List<double> data = [];
  var patientListController = DropdownController();
  //-----------------------------------

  getAccountType() async {
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();

    String? accountType = userPreferences.getString('account_type');
    var accountNumber = userPreferences.getInt('account_number');
    var userName = userPreferences.getString('user_name');
    setState(() {
      if (accountType == 'patient') {
        isPatient = true;
        patientID = accountNumber!;
        patientName = userName!;
      } else {
        doctorID = accountNumber!;
        isPatient = false;
      }
      isloaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getAccountType();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 270,
        child: Column(children: [
          const SizedBox(height: 15),
          Visibility(
            visible: !isPatient,
            child: PhysicianReport(
              doctorID: doctorID,
            ),
          ),
          Visibility(
            visible: isPatient && isloaded,
            child: PatientReport(
              patientID: patientID,
              patientName: patientName,
            ),
          )
        ]),
      ),
    );
  }
}
