import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/messaging/message_recipient.dart';
import 'package:muscletracking_app/componets/milestones/milestone_patient_summary.dart';
import 'package:muscletracking_app/componets/sliding_buttons.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:muscletracking_app/pages/send_mail.dart';
import 'package:muscletracking_app/utils/patient_progress.dart';

class PatientMilestonePage extends StatefulWidget {
  final int patientID;
  final String patientName;
  final int doctorID;
  const PatientMilestonePage(
      {super.key,
      required this.patientID,
      required this.patientName,
      required this.doctorID});

  @override
  State<PatientMilestonePage> createState() => _PatientMilestonePageState();
}

class _PatientMilestonePageState extends State<PatientMilestonePage> {
  int durationIndex = 0;
  bool isLoaded = false;
  PatientProgress currentPatient = PatientProgress(
      [0, 0, 0, 0], [0, 0, 0, 0], "Loading", "Loading duration", 0000);
  getPatientmilestones() async {
    String duration = "";
    switch (durationIndex) {
      case 0:
        duration = "day";
        break;
      case 1:
        duration = "week";
        break;
      case 2:
        duration = "month";
        break;
      case 3:
        duration = "year";
        break;
    }
    PatientProgress tempPatient =
        await getPatientSummary(widget.patientID, duration, widget.patientName);
    setState(() {
      currentPatient = tempPatient;
    });
  }

  gotoMessagePatient() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SendMail(
                recipients: [
                  MessageRecipient(
                      name: widget.patientName, recipientID: widget.patientID)
                ],
                accountNumber: widget.doctorID,
              )),
    );
  }

  @override
  void initState() {
    super.initState();
    getPatientmilestones();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          widget.patientName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 25),
            SlidingButtons(
              function: (index) {
                durationIndex = index;
                getPatientmilestones();
              },
              elements: {
                0: Image.asset('lib/icons/day.png'),
                1: Image.asset('lib/icons/week.png'),
                2: Image.asset('lib/icons/month.png'),
                3: Image.asset('lib/icons/year.png')
              },
            ),
            const SizedBox(height: 25),
            MilestonePatientSummary(patientData: currentPatient),
            Visibility(
                visible: widget.doctorID != widget.patientID,
                child: ElevatedButton(
                  onPressed: () {
                    gotoMessagePatient();
                  },
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepPurple)),
                  child: const Text("Message patient",
                      style: TextStyle(color: Colors.white)),
                ))
          ],
        ),
      ),
    );
  }
}
