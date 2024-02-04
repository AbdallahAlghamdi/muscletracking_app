import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/email_body_field.dart';
import 'package:muscletracking_app/componets/email_submit_button.dart';
import 'package:muscletracking_app/componets/email_title_field.dart';
import 'package:muscletracking_app/componets/messaging/message_recipient.dart';
import 'package:muscletracking_app/online/database.dart';
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

  SendMailButton() {
    print(recipientID);
    if (emailBodyController.text.isNotEmpty &&
        emailTitleController.text.isNotEmpty &&
        recipientID != null) {
      newMail(widget.accountNumber, recipientID!, emailBodyController.text,
          emailTitleController.text);
    } else {
      print("Not ready");
    }
  }

  recipientSelection(index) {
    print(index);
    setState(() {
      emailTitleController.text = "";
      emailBodyController.text = "";
      isRecipientSelected = true;
      recipientID = index;
    });
    menuController.close();
  }

  //----------variables----------
  int? recipientID;
  TextEditingController emailTitleController = TextEditingController();
  TextEditingController emailBodyController = TextEditingController();
  List<CoolDropdownItem> recipientList = [];
  DropdownController menuController = DropdownController();
  bool isRecipientSelected = false;
  //-----------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New Mail"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
          child: Column(
        children: [
          const SizedBox(height: 20),
          CoolDropdown(
              dropdownList: recipientList,
              controller: menuController,
              onChange: recipientSelection),
          EmailTitleField(
            emailTitleController: emailTitleController,
            isVisible: isRecipientSelected,
          ),
          EmailBodyField(
            controller: emailBodyController,
            isVisible: isRecipientSelected,
          ),
          EmailSubmitButton(
              function: SendMailButton, isVisible: isRecipientSelected),
        ],
      )),
    );
  }
}
