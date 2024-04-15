import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/alert_pop_up.dart';
import 'package:muscletracking_app/componets/long_button.dart';
import 'package:muscletracking_app/componets/account_type_selection.dart';
import 'package:muscletracking_app/componets/user_input_field.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:unicons/unicons.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  changeToggle(int index) {
    setState(() {
      isAccountTypeSelected = true;
      if (index == 0) {
        selectedOption[0] = true;
        selectedOption[1] = false;
      } else {
        selectedOption[0] = false;
        selectedOption[1] = true;
      }
    });
  }

  signupButton() async {
    if (signupButtonDisabled) {
      return;
    }
    setState(() {
      signupButtonDisabled = true;
    });
    if (accountNameField.text.isEmpty) {
      popUpMessages("Name is empty");
    } else if (usernameField.text.isEmpty) {
      popUpMessages("Username is empty");
    } else if (passwordField.text.isEmpty) {
      popUpMessages("Password is empty");
    } else {
      String accountType = "";
      if (selectedOption[0]) {
        accountType = "patient";
      } else {
        accountType = "doctor";
      }
      bool registrationSuccessful = await newAccount(usernameField.text,
          passwordField.text, accountNameField.text, accountType);
      checkStatus(registrationSuccessful);
    }
    setState(() {
      signupButtonDisabled = false;
    });
  }

  checkStatus(bool registrationSuccessful) {
    if (!registrationSuccessful) {
      popUpMessages("Username Taken!");
    } else {
      Navigator.pop(context);
      popUpMessages("your account has been successfully created!");
    }
  }

  popUpMessages(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertPopUp(
              text: message, icon: const Icon(Icons.account_box_rounded));
        });
  }

  //--------variables-----------
  List<bool> selectedOption = [false, false];
  TextEditingController usernameField = TextEditingController();
  TextEditingController accountNameField = TextEditingController();
  TextEditingController passwordField = TextEditingController();
  bool isAccountTypeSelected = false;
  bool signupButtonDisabled = false;
  //--------variables-----------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Signup"),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView(children: [
        Column(
          children: [
            const SizedBox(height: 20),
            const Text("Select account type", style: TextStyle(fontSize: 25)),
            const SizedBox(height: 20),
            AccountTypeSelection(
                changeToggle: changeToggle, selectedOption: selectedOption),
            Visibility(
              visible: isAccountTypeSelected,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const Text("Name", style: TextStyle(fontSize: 25)),
                  UserInputField(
                    controller: accountNameField,
                    isPassword: false,
                    icon: UniconsLine.user,
                    fieldName: "Name",
                    maxLength: 16,
                  ),
                  const Text("Username", style: TextStyle(fontSize: 25)),
                  UserInputField(
                    controller: usernameField,
                    isPassword: false,
                    icon: UniconsLine.user,
                    fieldName: "Username",
                    maxLength: 16,
                  ),
                  const Text("Password", style: TextStyle(fontSize: 25)),
                  UserInputField(
                    controller: passwordField,
                    isPassword: true,
                    icon: UniconsLine.keyhole_circle,
                    fieldName: "Password",
                    maxLength: 16,
                  ),
                ],
              ),
            ),
          ],
        ),
        Visibility(
          visible: isAccountTypeSelected,
          child: Container(
            margin: const EdgeInsets.only(bottom: 25),
            child: LongButton(
                function: signupButton,
                buttonText: "Signup",
                backgroundColor: const Color.fromARGB(255, 221, 191, 191)),
          ),
        ),
      ]),
    );
  }
}
