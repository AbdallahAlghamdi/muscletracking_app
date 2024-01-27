import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/messaging/message_room.dart';
import 'package:unicons/unicons.dart';

class MessageRecipient extends StatelessWidget {
  final String name;
  final int recipientID;
  final BuildContext context;
  const MessageRecipient(
      {super.key,
      required this.name,
      required this.recipientID,
      required this.context});

  gotoMessageRoom() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => MessageRoom(
                recipientName: "Khaled Ahmed",
                recipientID: recipientID,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gotoMessageRoom,
      child: Container(
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
                const Icon(
                  UniconsLine.user_circle,
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
      ),
    );
  }
}
