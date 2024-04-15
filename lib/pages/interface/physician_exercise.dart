import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/alert_pop_up.dart';
import 'package:muscletracking_app/componets/messaging/message_recipient.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:muscletracking_app/componets/add_patient_field.dart';
import 'package:muscletracking_app/componets/text_icon.dart';
import 'package:muscletracking_app/pages/edit_milestones.dart';
import 'package:unicons/unicons.dart';

class PhysicianExercise extends StatefulWidget {
  final int doctorID;
  const PhysicianExercise({super.key, required this.doctorID});
  @override
  State<PhysicianExercise> createState() => _PhysicianExerciseState();
}

class _PhysicianExerciseState extends State<PhysicianExercise> {
  List<MessageRecipient> recipients = [];

  getRecipients() async {
    Map<int, String> body = await getUserRecipients(widget.doctorID);
    List<MessageRecipient> tempRecipients = [];
    for (var element in body.entries) {
      tempRecipients
          .add(MessageRecipient(name: element.value, recipientID: element.key));
    }
    setState(() {
      recipients = tempRecipients;
    });
  }

  gotoPatientMilestoneView(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => EditMilestones(
              patientID: recipients[index].recipientID,
              patientName: recipients[index].name)),
    );
  }

  addPatient(String patient) async {
    bool successful = await addPatientByID(widget.doctorID, int.parse(patient));
    showDialogMessage(successful);
  }

  void showDialogMessage(bool successful) {
    if (!successful) {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertPopUp(
                text: "Can't add this patient", icon: Icon(UniconsLine.times));
          });
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return const AlertPopUp(
                text: "You added new patient!", icon: Icon(Icons.check));
          });
    }
  }

  @override
  void initState() {
    super.initState();
    getRecipients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Column(
              children: [
                TextIcon(
                  text: Text("Add patient",
                      style:
                          GoogleFonts.abel(fontSize: 27, color: Colors.black)),
                  icon: UniconsLine.user,
                ),
                AddPatientField(function: addPatient),
              ],
            ),
            const SizedBox(height: 10),
            const Text("Milestones", style: TextStyle(fontSize: 25)),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () => gotoPatientMilestoneView(index),
                  child: recipients[index],
                ),
                itemCount: recipients.length,
              ),
            )
          ],
        ),
      ),
    ));
  }
}
