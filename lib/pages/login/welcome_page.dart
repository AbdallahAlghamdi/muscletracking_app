import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/alert_pop_up.dart';
import 'package:muscletracking_app/componets/long_button.dart';
import 'package:muscletracking_app/componets/user_input_field.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:muscletracking_app/front_page.dart';
import 'package:muscletracking_app/pages/login/sign_up_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  loginButton() {
    //function when the button is clicked
    if (usernameField.text.isEmpty) {
      errorMessage(
          "Missing username"); //alert the user, the username is missing
      return;
    } else if (passwordField.text.isEmpty) {
      errorMessage(
          "Missing password"); //alert the user, the username is missing
      return;
    } else {
      loginProcess(); // if both fields are avaliable, then start the login process
    }
  }

  loginProcess() async {
    var loginInformation = await login(usernameField.text, passwordField.text);
    //retrieve the server response using the credentials provided.
    if (loginInformation.isEmpty) {
      //if the response is empty, then the credentials are wrong
      errorMessage('Wrong username or password');
    } else {
      String status = loginInformation["status"];
      int accountNumber = int.parse(loginInformation["account_number"]);
      String name = loginInformation["name"];
      setAccountInfo(
          status, accountNumber, name); //sets the account information
    }
  }

  void errorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertPopUp(text: message, icon: const Icon(UniconsLine.times));
        });
  }

  setAccountInfo(String accountType, int accountNumber, String name) async {
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance(); //get the internal data
    userPreferences.setString("account_type", accountType); //Account type
    userPreferences.setString("user_name", name); //account's name
    userPreferences.setInt("account_number", accountNumber); // account number
    gotoFrontpage(); //then go to the front page
  }

  gotoFrontpage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const FrontPage(),
      ),
    );
  }

  gotoSignupPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SignUpPage(),
      ),
    );
  }

  //---------variables----------
  TextEditingController usernameField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  //----------------------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 240, 240, 240),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 25, top: 20, right: 25, bottom: 25),
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 2, color: const Color(0xffe6e6e6)),
                    borderRadius: BorderRadius.circular(2)),
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    Text("MuscleTrack",
                        style: GoogleFonts.acme(
                            fontSize: 45, color: Colors.black)),
                    Image.asset("lib/icons/muscleLogo.png", width: 200),
                    const SizedBox(height: 10),
                    UserInputField(
                      controller: usernameField,
                      isPassword: false,
                      icon: UniconsLine.mailbox,
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
                      backgroundColor: const Color.fromARGB(255, 165, 202, 243),
                      buttonText: "login",
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.only(left: 25, right: 25, bottom: 25),
                decoration: BoxDecoration(
                    color: const Color(0xffffffff),
                    border:
                        Border.all(width: 2, color: const Color(0xffe6e6e6)),
                    borderRadius: BorderRadius.circular(2)),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const Text("Don't have an account?",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w300)),
                    LongButton(
                        function: gotoSignupPage,
                        buttonText: "Signup",
                        backgroundColor:
                            const Color.fromARGB(255, 221, 191, 191)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
              Text(
                DateTime.now().toString().substring(0, 10),
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
