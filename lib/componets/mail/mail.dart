import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:unicons/unicons.dart';

class Mail extends StatefulWidget {
  final int messageID;
  final String fromUser;
  final String toUser;
  final String message;
  final DateTime time;
  final String title;
  final bool hasRead;
  final bool isSent;
  const Mail(
      {super.key,
      required this.fromUser,
      required this.toUser,
      required this.message,
      required this.time,
      required this.title,
      required this.hasRead,
      required this.isSent,
      required this.messageID});

  @override
  State<Mail> createState() => _MailState();
}

class _MailState extends State<Mail> {
  bool isRead = false;
  bool showMessage = false;
  final TextStyle style = const TextStyle(color: Colors.white);

  String formatDateTime(DateTime time) {
    return "${time.year}-${time.month}-${time.day}\t${time.hour}:${time.minute}";
  }

  @override
  void initState() {
    super.initState();
    isRead = widget.hasRead;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() {
        showMessage = !showMessage;
        if (isRead == false) {
          setState(() {
            isRead = true;
          });
          setMessageOpened(widget.messageID);
        }
      }),
      child: Container(
        margin: const EdgeInsets.only(left: 25, right: 25, bottom: 10),
        padding:
            const EdgeInsets.only(left: 25, right: 25, bottom: 25, top: 10),
        decoration: BoxDecoration(
            color: Colors.deepPurpleAccent,
            borderRadius: BorderRadius.circular(25)),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Visibility(
                visible: widget.isSent, child: const SizedBox(height: 15)),
            Visibility(
              visible: !widget.isSent,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(
                      isRead ? UniconsLine.envelope_open : UniconsLine.envelope,
                      color: Colors.white),
                ],
              ),
            ),
            RichText(
                text: TextSpan(
                    text: "Subject: ",
                    style: const TextStyle(color: Colors.white60),
                    children: [
                  TextSpan(
                      text: widget.title,
                      style: const TextStyle(color: Colors.white)),
                ])),
            // Text(
            //   "Subject: ${widget.title}",
            //   style:
            //       TextStyle(color: Colors.white60, fontWeight: FontWeight.bold),
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                    text: TextSpan(
                        text: "From: ",
                        style: const TextStyle(color: Colors.white60),
                        children: [
                      TextSpan(
                          text: widget.fromUser,
                          style: const TextStyle(color: Colors.white)),
                    ])),
                RichText(
                    text: TextSpan(
                        text: "To: ",
                        style: const TextStyle(color: Colors.white60),
                        children: [
                      TextSpan(
                          text: widget.toUser,
                          style: const TextStyle(color: Colors.white)),
                    ])),
              ],
            ),

            RichText(
                text: TextSpan(
                    text: "Date: ",
                    style: const TextStyle(color: Colors.white60),
                    children: [
                  TextSpan(
                      text: formatDateTime(widget.time),
                      style: const TextStyle(color: Colors.white)),
                ])),

            Visibility(
              visible: showMessage,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 13,
                  ),
                  Container(
                    height: 2,
                    color: const Color.fromARGB(255, 191, 191, 191),
                    width: double.infinity,
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Text(
                    widget.message,
                    style: style,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
