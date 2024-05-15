import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/graph_data.dart';
import 'package:muscletracking_app/componets/messaging/message_recipient.dart';
import 'package:muscletracking_app/componets/milestones/patient_list.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:muscletracking_app/componets/patient_condition.dart';
import 'package:muscletracking_app/componets/sliding_buttons.dart';
import 'package:muscletracking_app/componets/text_icon.dart';
import 'package:muscletracking_app/pages/detailed_report.dart';
import 'package:muscletracking_app/pages/send_mail.dart';
import 'package:unicons/unicons.dart';

class PhysicianReport extends StatefulWidget {
  final int doctorID;
  const PhysicianReport({super.key, required this.doctorID});

  @override
  State<PhysicianReport> createState() => _PhysicianReportState();
}

class _PhysicianReportState extends State<PhysicianReport> {
  bool showGraph = false;
  bool isDataAvaliable = false;
  bool showMuscleSlide = false;
  int patientID = 0;
  String patientName = "";
  String muscleSelectedGroup = "Bicep";
  List<CoolDropdownItem<int>> patientsName = [];
  String duration = "Day";
  List<double> data = [];
  DropdownController patientListController = DropdownController();

  gotoMessagePatient() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SendMail(
                recipients: [
                  MessageRecipient(name: patientName, recipientID: patientID)
                ],
                accountNumber: widget.doctorID,
              )),
    );
  }

  getAvgMuscleData() async {
    var tempData = await getAverageMuscleData(
        patientID, muscleSelectedGroup, duration.toLowerCase()[0]);

    if (mounted) {
      setState(() {
        data = tempData;
        if (data.isNotEmpty) {
          isDataAvaliable = true;
        }
      });
    }
  }

  slidingMuscleButtons(int index) {
    resetData();
    setState(() {
      showGraph = true;
      switch (index) {
        case 0:
          muscleSelectedGroup = "Bicep";
          break;
        case 1:
          muscleSelectedGroup = "Calf";
          break;
        case 2:
          muscleSelectedGroup = "Forearm";
          break;
        case 3:
          muscleSelectedGroup = "Thigh";
          break;
      }
    });
    getAvgMuscleData();
  }

  resetData() {
    setState(() {
      isDataAvaliable = false;
      data = [];
    });
  }

  slidingDurationButtons(int index) {
    resetData();
    setState(() {
      showGraph = true;
      switch (index) {
        case 0:
          duration = "Day";
          break;
        case 1:
          duration = "Week";
          break;
        case 2:
          duration = "Month";
          break;
        case 3:
          duration = "Year";
          break;
      }
    });
    getAvgMuscleData();
  }

  patientSelected(int index) {
    patientName = "";
    for (var element in patientsName) {
      if (element.value == index) {
        patientName = element.label;
        break;
      }
    }
    patientListController.close();
    setState(() {
      patientID = index;
      showMuscleSlide = true;
      showGraph = true;
    });
    getAvgMuscleData();
  }

  goToDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailedReport(
                muscleGroup: muscleSelectedGroup,
                accountNumber: patientID,
              )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Select Patient',
                style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
          ],
        ),
        const SizedBox(height: 20),
        PatientList(
          patientsName: patientsName,
          doctorID: widget.doctorID,
          function: patientSelected,
          controller: patientListController,
        ),
        const SizedBox(height: 20),
        Visibility(
          visible: showMuscleSlide,
          child: Column(
            children: [
              SlidingButtons(
                function: slidingMuscleButtons,
                elements: {
                  0: Image.asset('lib/icons/bicep.png'),
                  1: Image.asset('lib/icons/calf.png'),
                  2: Image.asset('lib/icons/forearm.png'),
                  3: Image.asset('lib/icons/thigh.png')
                },
              ),
              const SizedBox(height: 10),
              Text(muscleSelectedGroup,
                  style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
              const SizedBox(height: 10),
              SlidingButtons(
                function: slidingDurationButtons,
                elements: {
                  0: Image.asset('lib/icons/day.png'),
                  1: Image.asset('lib/icons/week.png'),
                  2: Image.asset('lib/icons/month.png'),
                  3: Image.asset('lib/icons/year.png')
                },
              )
            ],
          ),
        ),
        Visibility(
          visible: showGraph,
          child: Column(
            children: [
              const SizedBox(height: 20),
              PatientCondition(
                data: data,
                patientName: patientName,
                muscleName: muscleSelectedGroup,
                duration: duration,
              ),
              GraphData(data: data),
              Visibility(
                visible: isDataAvaliable,
                child: ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.deepPurpleAccent)),
                    onPressed: goToDetails,
                    child: const TextIcon(
                        text: Text("Details",
                            style: TextStyle(color: Colors.white)),
                        icon: UniconsLine.document_info)),
              ),
              ElevatedButton(
                onPressed: () {
                  gotoMessagePatient();
                },
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Colors.deepPurple)),
                child: const Text("Message patient",
                    style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
