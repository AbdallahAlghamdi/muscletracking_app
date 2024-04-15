import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserInputField extends StatelessWidget {
  final bool
      isPassword; //Boolean check if the field is a password, sets it as Astrix
  final IconData icon; //Icon on the left side of the field.
  final String fieldName; //set the name of the field
  final int maxLength; //max number of characters allowed
  final TextEditingController
      controller; //used to retrieve the data from the field

  const UserInputField(
      {super.key,
      required this.isPassword,
      required this.icon,
      required this.fieldName,
      required this.controller,
      required this.maxLength});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(77, 192, 192, 192),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: TextField(
        inputFormatters: [LengthLimitingTextInputFormatter(maxLength)],
        controller: controller,
        decoration: InputDecoration(
            prefix: Container(
              margin: const EdgeInsets.only(right: 5),
              child: Icon(
                icon,
                color: const Color.fromARGB(255, 93, 93, 93),
              ),
            ),
            focusColor: Colors.black,
            enabledBorder: const OutlineInputBorder(
                borderSide:
                    BorderSide(color: Color.fromARGB(255, 193, 193, 193))),
            focusedBorder: const OutlineInputBorder(borderSide: BorderSide()),
            label: Text(
              fieldName,
              style: const TextStyle(color: Color.fromARGB(255, 93, 93, 93)),
            ),
            contentPadding: const EdgeInsets.all(8)),
        obscureText: isPassword,
      ),
    );
  }
}
