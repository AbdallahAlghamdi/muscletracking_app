import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/patient_or_physician.dart';
import 'package:muscletracking_app/componets/text_field_add.dart';
import 'package:muscletracking_app/componets/text_icon.dart';
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
  int accountNumber = 0;
  void getAccountType() async {
    print("getting account type");
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();

    String accountType = userPreferences.get('account_type').toString();
    if (accountType != "patient") {
      setState(() {
        accountNumber = userPreferences.getInt("account_number")!;
        isPatient = false;
      });
    }
  }

  @override
  initState() {
    getAccountType();
    super.initState();
  }

  final List<bool> selectedOption = <bool>[false, false];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Text("Account type",
                    style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
                const SizedBox(height: 15),
                Visibility(
                    visible: !isPatient,
                    child: Column(
                      children: [
                        const TextIcon(
                          text: Text("Add new patient"),
                          icon: UniconsLine.user,
                        ),
                        const SizedBox(height: 10),
                        TextFieldAdd(
                            function: (patient) => addPatientByID(
                                accountNumber, int.parse(patient))),
                      ],
                    )),
              ],
            ),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () =>
                      Navigator.pushReplacementNamed(context, '/loginPage'),
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepPurple)),
                  child: const Text("Sign out"),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutPage()),
                    );
                  },
                  icon: const Icon(Icons.info),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
