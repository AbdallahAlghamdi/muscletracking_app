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
      }
      if (tempAccountNumber != null) {
        accountNumber = tempAccountNumber;
      }
      isLoaded = true;
    });
    if (!isPatient) {
      getPatientSummary();
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
    // TODO: implement initState
    super.initState();
    getAccount();
  }

  getPatientSummary() async {
    Map<int, PatientProgress> body = await getSummaryMilestones(2142);
    List<PatientProgress> tempPatientsList = [];
    for (var element in body.entries) {
      tempPatientsList.add(element.value);
    }
    setState(() {
      patientsProgress = tempPatientsList;
    });
  }

  gotoSummaryDetails(int index) {
    String patientName = patientsProgress[index].name;
    int accountNumber = patientsProgress[index].accountNumber;
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => PatientMilestonePage(
                patientID: accountNumber,
                patientName: patientName,
                doctorID: accountNumber,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: isLoaded,
        child: Column(
          children: [
            const SizedBox(height: 30),
            Text("Welcome $accountName", style: const TextStyle(fontSize: 25)),
            Visibility(
                visible: messagesLoaded,
                child: MailNotification(
                  isMessageLoaded: messagesLoaded,
                  notificationCount: notificationCount,
                )),
            Expanded(
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
          ],
        ),
      ),
    );
  }
}
