import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/patient_or_physician.dart';
import 'package:muscletracking_app/componets/text_field_add.dart';
import 'package:muscletracking_app/online/database.dart';
import 'package:muscletracking_app/pages/about_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool isPatient = true;
  void getCurrentAccountType() async {
    print("getting account type");
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();

    String accountType = userPreferences.get('account_type').toString();
    if (accountType == 'Patient') {
      isPatient = true;
      changeToggle(0);
    } else {
      isPatient = false;
      changeToggle(1);
    }
  }

  @override
  initState() {
    getCurrentAccountType();
    super.initState();
  }

  setAccountType(int index) async {
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();
    if (index == 0) {
      await userPreferences.setString('account_type', "Patient");
    } else {
      await userPreferences.setString('account_type', "Doctor");
    }
  }

  changeToggle(int index) {
    setState(() {
      for (var i = 0; i < selectedOption.length; i++) {
        selectedOption[i] = (i == index);
      }
    });
    setAccountType(index);
  }

  final List<bool> selectedOption = <bool>[false, false];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          children: [
            Text("Account type",
                style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
            const SizedBox(height: 5),
            PatientOrPhysician(
                changeToggle: changeToggle, selectedOption: selectedOption),
            const SizedBox(height: 15),
            Visibility(
                visible: !isPatient,
                child: TextFieldAdd(
                    function: (patient) =>
                        addPatientByID(2142, int.parse(patient)))),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AboutPage()),
                );
              },
              icon: const Icon(Icons.info),
            ),
          ],
        ),
      ),
    );
  }
}
