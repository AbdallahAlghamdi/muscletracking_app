import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class MessageRecipient extends StatelessWidget {
  final String name;
  final bool isPatient;
  final DateTime lastMessageDate;
  const MessageRecipient(
      {super.key,
      required this.name,
      required this.isPatient,
      required this.lastMessageDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
          color: const Color.fromARGB(136, 197, 191, 191),
          borderRadius: BorderRadius.circular(10)),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              const SizedBox(width: 20),
              Icon(
                isPatient ? UniconsLine.user_circle : UniconsLine.user_md,
                size: 37,
              ),
              const SizedBox(width: 15),
              Text(
                name,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
          Container(
              margin: const EdgeInsets.only(right: 20),
              child: const Icon(UniconsLine.arrow_right, size: 40)),
        ],
      ),
    );
  }
}
