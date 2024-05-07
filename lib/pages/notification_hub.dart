import 'package:flutter/material.dart';
import 'package:muscletracking_app/componets/mail/mail_notification.dart';
import 'package:muscletracking_app/componets/milestones/milestone_patient_summary.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:muscletracking_app/pages/patient_milestone_page.dart';
import 'package:muscletracking_app/utils/patient_progress.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationHub extends StatefulWidget {
  const NotificationHub({super.key});

  @override
  State<NotificationHub> createState() => _NotificationHubState();
}

class _NotificationHubState extends State<NotificationHub> {
  bool isPatient = false;
  bool isLoaded = false;
  bool messagesLoaded = false;
  String accountName = "";
  int accountNumber = 0;
  int notificationCount = 0;
  List<PatientProgress> patientsProgress = [];

  getAccount() async {
    SharedPreferences prefereces = await SharedPreferences.getInstance();
    String? tempAccountType = prefereces.getString("account_type");
    String? tempAccountName = prefereces.getString("user_name");
    int? tempAccountNumber = prefereces.getInt("account_number");
    setState(() {
      if (tempAccountType != null) {
        isPatient = tempAccountType == "patient";
      }
      if (tempAccountName != null) {
        accountName = tempAccountName;
        accountName = accountName[0].toUpperCase() +
            accountName.substring(1).toLowerCase();
      }
      if (tempAccountNumber != null) {
        accountNumber = tempAccountNumber;
      }
      isLoaded = true;
    });
    if (!isPatient) {
      getPatientsSummary();
    }
    readNotifications(accountNumber);
  }

  readNotifications(int accountNumber) async {
    notificationCount = await getNotifications(accountNumber);
    setState(() {
      messagesLoaded = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getAccount();
  }

  getPatientsSummary() async {
    Map<int, PatientProgress> body = await getSummaryMilestones(accountNumber);
    List<PatientProgress> tempPatientsList = [];
    for (var element in body.entries) {
      tempPatientsList.add(element.value);
    }
    setState(() {
      patientsProgress = tempPatientsList;
    });
  }

  gotoSummaryDetails(int index) {
    String patientName;
    int patientID = 0;
    if (!isPatient) {
      patientName = patientsProgress[index].name;
      patientID = patientsProgress[index].accountNumber;
    } else {
      patientName = accountName;
      patientID = accountNumber;
    }
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PatientMilestonePage(
                patientID: patientID,
                patientName: patientName,
                doctorID: accountNumber,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Visibility(
          visible: isLoaded,
          child: Column(
            children: [
              const SizedBox(height: 10),
              Text("Welcome $accountName",
                  style: const TextStyle(fontSize: 25)),
              Visibility(
                  visible: messagesLoaded,
                  child: MailNotification(
                    isMessageLoaded: messagesLoaded,
                    notificationCount: notificationCount,
                  )),
              Visibility(
                replacement: ElevatedButton(
                    onPressed: () {
                      gotoSummaryDetails(accountNumber);
                    },
                    child: const Text(
                      "View milestone",
                      style: TextStyle(color: Colors.deepPurple),
                    )),
                visible: !isPatient,
                child: Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 40, right: 40),
                    child: ListView.builder(
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () => gotoSummaryDetails(index),
                        child: MilestonePatientSummary(
                            patientData: patientsProgress[index]),
                      ),
                      itemCount: patientsProgress.length,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
