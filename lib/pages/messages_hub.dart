import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/messaging/message_recipient.dart';

class MessageHub extends StatefulWidget {
  const MessageHub({super.key});

  @override
  State<MessageHub> createState() => _MessageState();
}

class _MessageState extends State<MessageHub> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: 15),
          Text('Your messages',
              style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
          SizedBox(height: 15),
          Expanded(
            child: ListView(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              children: [
                MessageRecipient(
                  name: "Khaled Ahmed",
                  isPatient: true,
                  lastMessageDate: DateTime(2017, 9, 7, 17, 30),
                ),
                MessageRecipient(
                  name: "Saleh Alghamdi",
                  isPatient: true,
                  lastMessageDate: DateTime(2017, 9, 7, 17, 30),
                ),
                MessageRecipient(
                  name: "Kholod Ahsan",
                  isPatient: true,
                  lastMessageDate: DateTime(2017, 9, 7, 17, 30),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
