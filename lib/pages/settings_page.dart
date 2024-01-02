import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  void getCurrentAccountType() async {
    print("getting account type");
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();

    String accountType = userPreferences.get('account_type').toString();
    if (accountType == 'Patient') {
      changeToggle(0);
    } else {
      changeToggle(1);
    }
  }

  @override
  void initState() {
    getCurrentAccountType();
    super.initState();
  }

  void setAccountType(int index) async {
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();
    if (index == 0) {
      await userPreferences.setString('account_type', "Patient");
    } else {
      await userPreferences.setString('account_type', "Doctor");
    }
  }

  void changeToggle(int index) {
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
      child: Column(
        children: [
          Text(
            "Account type",
            style: GoogleFonts.abel(fontSize: 27, color: Colors.black),
          ),
          const SizedBox(height: 5),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.deepPurple,
            ),
            child: ToggleButtons(
              borderWidth: 4,
              borderRadius: BorderRadius.circular(6),
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              fillColor: Colors.white,
              isSelected: selectedOption,
              onPressed: changeToggle,
              children: [
                Image.asset(
                  'lib/icons/icon_patient.png',
                  width: 40,
                ),
                Image.asset(
                  'lib/icons/icon_doctor.png',
                  width: 40,
                ),
              ],
            ),
          )
          // SlidingButtons(
          //     intialValue: index,
          //     passedFunction: setAccountType,
          //     elements: {
          //       0: Image.asset('lib/icons/icon_patient.png'),
          //       1: Image.asset('lib/icons/icon_doctor.png'),
          //     })
        ],
      ),
    );
  }
}
