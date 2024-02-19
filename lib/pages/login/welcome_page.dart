import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/error_box.dart';
import 'package:muscletracking_app/componets/long_button.dart';
import 'package:muscletracking_app/componets/user_input_field.dart';
import 'package:muscletracking_app/componets/online/database.dart';
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

  gotoFrontpage() async {
    Navigator.pushReplacementNamed(
      context,
      '/frontPage',
    );
  }

  gotoSignupPage() {
    Navigator.pushNamed(context, '/signupPage');
  }

  //---------variables----------
  TextEditingController usernameField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  bool usernameMissing = false;
  bool passwordMissing = false;
  bool wrongCredentials = false;
  bool showErrorMenu = false;
  String name = "";
  String status = "";
  String errorMessage = "";
  //----------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xf9f9f9FF),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(
                  left: 25, top: 40, right: 25, bottom: 25),
              decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  border: Border.all(width: 2, color: const Color(0xffe6e6e6)),
                  borderRadius: BorderRadius.circular(2)),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  Text("Welcome",
                      style:
                          GoogleFonts.acme(fontSize: 45, color: Colors.black)),
                  const Icon(UniconsLine.linux, size: 60),
                  const SizedBox(height: 20),
                  UserInputField(
                    controller: usernameField,
                    isPassword: false,
                    icon: UniconsLine.user,
                    fieldName: "Username",
                    maxLength: 16,
                  ),
                  UserInputField(
                    controller: passwordField,
                    isPassword: true,
                    icon: UniconsLine.keyhole_circle,
                    fieldName: "Password",
                    maxLength: 16,
                  ),
                  LongButton(
                    function: loginButton,
                    backgroundColor: Color.fromARGB(255, 165, 202, 243),
                    buttonText: "login",
                  ),
                  const SizedBox(height: 10),
                  ErrorBox(warningMessage: errorMessage, show: showErrorMenu),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
              decoration: BoxDecoration(
                  color: const Color(0xffffffff),
                  border: Border.all(width: 2, color: Color(0xffe6e6e6)),
                  borderRadius: BorderRadius.circular(2)),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  const Text("Don't have an account?",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w300)),
                  LongButton(
                      function: gotoSignupPage,
                      buttonText: "Signup",
                      backgroundColor:
                          const Color.fromARGB(255, 221, 191, 191)),
                  const SizedBox(height: 20)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
