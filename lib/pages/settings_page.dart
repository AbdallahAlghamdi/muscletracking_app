import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/error_box.dart';
import 'package:muscletracking_app/componets/success_box.dart';
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
  String successMessage = "";
  bool showSuccess = false;
  bool isPatient = true;
  bool showError = false;
  String errorMessage = "";
  int accountNumber = 0;
  void getAccountType() async {
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

  addPatient(String patient) async {
    if (showError || showSuccess) {
      setState(() {
        showError = false;
        showSuccess = false;
      });
    }
    bool succesful = await addPatientByID(accountNumber, int.parse(patient));
    if (!succesful) {
      setState(() {
        showError = true;
        errorMessage = "Can't add this patient";
      });
    } else {
      setState(() {
        showSuccess = true;
        successMessage = "You added new patient";
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
                const SizedBox(height: 15),
                Visibility(
                    visible: !isPatient,
                    child: Column(
                      children: [
                        TextIcon(
                          text: Text("Add patient",
                              style: GoogleFonts.abel(
                                  fontSize: 27, color: Colors.black)),
                          icon: UniconsLine.user,
                        ),
                        const SizedBox(height: 10),
                        TextFieldAdd(function: addPatient),
                        const SizedBox(height: 25),
                        ErrorBox(warningMessage: errorMessage, show: showError),
                        const SizedBox(height: 25),
                        SuccessBox(
                            sucesssMessage: successMessage, show: showSuccess)
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
                  child: const Text(
                    "Sign out",
                    style: TextStyle(color: Colors.white),
                  ),
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
