import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/messaging/message_recipient.dart';
import 'package:muscletracking_app/online/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PhysicianExercise extends StatefulWidget {
  const PhysicianExercise({super.key});

  @override
  State<PhysicianExercise> createState() => _PhysicianExerciseState();
}

class _PhysicianExerciseState extends State<PhysicianExercise> {
  List<MessageRecipient> recipients = [];
  getRecipients() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    int? accountNumber = preferences.getInt("account_number");
    if (accountNumber != null) {
      Map<int, String> body = await getUserRecipients(accountNumber!);
      List<MessageRecipient> tempRecipients = [];
      for (var element in body.entries) {
        tempRecipients.add(
            MessageRecipient(name: element.value, recipientID: element.key));
      }
      setState(() {
        recipients = tempRecipients;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          const Text("Milestones", style: TextStyle(fontSize: 25)),
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) => recipients[index],
              itemCount: recipients.length,
            ),
          )
        ],
      ),
    ));
  }
}
