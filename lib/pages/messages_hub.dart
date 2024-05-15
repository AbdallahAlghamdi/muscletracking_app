import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/mail/mail.dart';
import 'package:muscletracking_app/componets/mail/mail_list.dart';
import 'package:muscletracking_app/componets/messaging/message_recipient.dart';
import 'package:muscletracking_app/componets/toggle_button_mail.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:muscletracking_app/pages/send_mail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unicons/unicons.dart';

class MessageHub extends StatefulWidget {
  const MessageHub({super.key});

  @override
  State<MessageHub> createState() => _MessageState();
}

class _MessageState extends State<MessageHub> {
  int? accountNumber;
  List<MessageRecipient> recipients = [];
  List<Mail> mail = [];
  String isInbox = "inbox";

  getRecipients() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    accountNumber = preferences.getInt("account_number");
    if (accountNumber != null) {
      Map<int, String> body = await getUserRecipients(accountNumber!);
      List<MessageRecipient> tempRecipients = [];
      for (var element in body.entries) {
        tempRecipients.add(
            MessageRecipient(name: element.value, recipientID: element.key));
      }
      if (mounted) {
        setState(() {
          recipients = tempRecipients;
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipients();
    getMailMessages(isInbox);
  }

  getMailMessages(String mailType) async {
    List<Mail> tempMail = [];
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? accountNumber = preferences.getInt("account_number");
    String? name = preferences.getString("user_name");
    if (accountNumber != null && name != null) {
      if (mailType == "inbox") {
        tempMail = await getMail(accountNumber, name);
      } else {
        tempMail = await getSentMail(accountNumber, name);
      }
    }
    setState(() {
      mail = tempMail.reversed.toList();
    });
  }

  toggleButtonChanged(Set<String> input) {
    if (input.isNotEmpty) {
      setState(() {
        isInbox = input.first;
        mail = [];
      });

      getMailMessages(isInbox);
    }
  }

  gotoNewMail() {
    if (accountNumber != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SendMail(
                  recipients: recipients,
                  accountNumber: accountNumber!,
                )),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          ToggleButtonMail(isOutBound: isInbox, function: toggleButtonChanged),
          MailList(mail: mail),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Visibility(
                visible: recipients.isNotEmpty,
                child: Container(
                  margin: const EdgeInsets.all(25),
                  child: FloatingActionButton(
                    onPressed: gotoNewMail,
                    backgroundColor: Colors.deepPurple,
                    child: const Icon(
                      UniconsLine.envelope,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
