import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/messaging/message_recipient.dart';
import 'package:muscletracking_app/componets/messaging/message_room.dart';
import 'package:muscletracking_app/online/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageHub extends StatefulWidget {
  const MessageHub({super.key});

  @override
  State<MessageHub> createState() => _MessageState();
}

class _MessageState extends State<MessageHub> {

  Future<List<Widget>> getRecipients() async {
    List<Widget> recipients = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(preferences.getInt("account_number"));
    var account_number = preferences.getInt("account_number");
    if (account_number != null) {
      Map<int, String> body = await getUserRecipients(account_number);
        for (var element in body.entries) {
          // ignore: use_build_context_synchronously
          recipients.add(MessageRecipient(
              name: element.value, recipientID: element.key, context: context));
        }
    }
  }
  Future<List<Widget>> recipients = getRecipients();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipients();
  }

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
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemBuilder: (BuildContext context, int index) {},
            ),
          )
        ],
      ),
    );
  }
}
