import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/mail/mail.dart';

class MailList extends StatelessWidget {
  final List<Mail> mail;
  const MailList({super.key, required this.mail});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (context, index) {
          return mail[index];
        },
        itemCount: mail.length,
      ),
    );
  }
}
