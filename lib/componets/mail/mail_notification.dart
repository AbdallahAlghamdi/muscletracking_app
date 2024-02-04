import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

class MailNotification extends StatelessWidget {
  final int notificationCount;
  final bool isMessageLoaded;
  const MailNotification(
      {super.key,
      required this.notificationCount,
      required this.isMessageLoaded});

  @override
  Widget build(BuildContext context) {
    return Visibility(
        visible: isMessageLoaded,
        child: Container(
          width: double.infinity,
          height: 100,
          padding:
              const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
          child: Container(
            width: 200,
            decoration: BoxDecoration(
                color: Colors.deepPurple,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    width: 3, color: const Color.fromARGB(255, 72, 37, 132))),
            child: notificationCount > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You got $notificationCount new mail",
                        style:
                            const TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Icon(
                        UniconsLine.envelope_exclamation,
                        color: Colors.white,
                      )
                    ],
                  )
                : const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "You caught up with all your mail!",
                        style: TextStyle(fontSize: 17, color: Colors.white),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(UniconsLine.envelope_open, color: Colors.white)
                    ],
                  ),
          ),
        ));
  }
}
