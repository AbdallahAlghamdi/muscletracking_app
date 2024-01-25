import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class UserInputField extends StatelessWidget {
  final bool isPassword;
  final IconData icon;
  final String fieldName;
  final TextEditingController controller;

  const UserInputField(
      {super.key,
      required this.isPassword,
      required this.icon,
      required this.fieldName,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(77, 192, 192, 192),
      margin: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: TextField(
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
