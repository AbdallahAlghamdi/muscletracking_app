import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/alert_pop_up.dart';
import 'package:muscletracking_app/componets/mail_body_field.dart';
import 'package:muscletracking_app/componets/mail_submit_button.dart';
import 'package:muscletracking_app/componets/mail_title_field.dart';
import 'package:muscletracking_app/componets/messaging/message_recipient.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:unicons/unicons.dart';

class SendMail extends StatefulWidget {
  final List<MessageRecipient> recipients;
  final int accountNumber;
  const SendMail(
      {super.key, required this.recipients, required this.accountNumber});

  @override
  State<SendMail> createState() => _SendMailState();
}

class _SendMailState extends State<SendMail> {
  @override
  void initState() {
    super.initState();
    setRecipients();
  }

  setRecipients() {
    for (var element in widget.recipients) {
      recipientList.add(
          CoolDropdownItem(label: element.name, value: element.recipientID));
    }
  }

  sendMailButton() {
    if (mailBodyController.text.isEmpty) {
      popUpMessages(
          "Mail body is missing", const Icon(UniconsLine.envelope_block));
      return;
    } else if (mailTitleController.text.isEmpty) {
      popUpMessages(
          "Mail body is missing", const Icon(UniconsLine.envelope_block));
      return;
    }
    newMail(widget.accountNumber, recipientID, mailBodyController.text.trim(),
        mailTitleController.text.trim());
    Navigator.pop(context);
    popUpMessages("Mail sent", const Icon(UniconsLine.mailbox));
  }

  popUpMessages(String message, Icon icon) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertPopUp(text: message, icon: icon);
        });
  }

  recipientSelection(index) {
    setState(() {
      mailTitleController.text = "";
      mailBodyController.text = "";
      isRecipientSelected = true;
      recipientID = index;
    });
    menuController.close();
  }

  //----------variables----------
  int recipientID = 0;
  TextEditingController mailTitleController = TextEditingController();
  TextEditingController mailBodyController = TextEditingController();
  List<CoolDropdownItem> recipientList = [];
  DropdownController menuController = DropdownController();
  bool isRecipientSelected = false;
  //-----------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "New Mail",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView(children: [
        Column(
          children: [
            const SizedBox(height: 20),
            CoolDropdown(
                dropdownList: recipientList,
                controller: menuController,
                onChange: recipientSelection),
            MailTitleField(
              controller: mailTitleController,
              isVisible: isRecipientSelected,
            ),
            MailBodyField(
              controller: mailBodyController,
              isVisible: isRecipientSelected,
            ),
            MailSubmitButton(
                function: sendMailButton, isVisible: isRecipientSelected),
          ],
        ),
      ]),
    );
  }
}
