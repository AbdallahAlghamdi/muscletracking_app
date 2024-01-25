import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/error_box.dart';
import 'package:muscletracking_app/componets/login_button.dart';
import 'package:muscletracking_app/componets/user_input_field.dart';
import 'package:muscletracking_app/front_page.dart';
import 'package:muscletracking_app/online/database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  loginButton() {
    setState(() {
      showErrorMenu = true;
      if (usernameField.text.isEmpty) {
        showErrorMenu = true;
        usernameMissing = true;
        errorMessage = "Missing username";
        return;
      } else if (passwordField.text.isEmpty) {
        showErrorMenu = true;
        passwordMissing = true;
        errorMessage = "Missing password";
        return;
      } else {
        showErrorMenu = false;
        loginProcess();
      }
    });
  }

  loginProcess() async {
    var loginInformation = await login(usernameField.text, passwordField.text);
    if (loginInformation == null) {
      setState(() {
        wrongCredentials = true;
        showErrorMenu = true;
        errorMessage = "Wrong username or password";
      });
    } else {
      setState(() {
        String status = loginInformation["status"];
        int accountNumber = int.parse(loginInformation["account_number"]);
        String name = loginInformation["name"];
        setAccountInfo(status, accountNumber, name);
      });
    }
  }

  setAccountInfo(String accountType, int accountNumber, String name) async {
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();
    userPreferences.setString("account_type", accountType);
    userPreferences.setString("user_name", name);
    userPreferences.setInt("account_number", accountNumber);
    gotoFrontpage();
  }

  gotoFrontpage() {
    Navigator.pushReplacementNamed(context, '/frontPage');
  }

  TextEditingController usernameField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  bool usernameMissing = false;
  bool passwordMissing = false;
  bool wrongCredentials = false;
  bool showErrorMenu = false;
  String name = "";
  String status = "";
  String errorMessage = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40),
            Text("Welcome",
                style: GoogleFonts.acme(fontSize: 45, color: Colors.black)),
            const Icon(UniconsLine.linux, size: 100),
            const SizedBox(height: 20),
            UserInputField(
                controller: usernameField,
                isPassword: false,
                icon: UniconsLine.user,
                fieldName: "Username"),
            UserInputField(
                controller: passwordField,
                isPassword: true,
                icon: UniconsLine.keyhole_circle,
                fieldName: "Password"),
            LoginButton(function: loginButton),
            ErrorBox(warningMessage: errorMessage, show: showErrorMenu),
          ],
        ),
      ),
    );
  }
}
