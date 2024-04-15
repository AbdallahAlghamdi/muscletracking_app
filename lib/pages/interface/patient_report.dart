import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/online/database.dart';
import 'package:muscletracking_app/componets/patient_condition.dart';
import 'package:muscletracking_app/componets/sliding_buttons.dart';

class PatientReport extends StatefulWidget {
  final int patientID;
  final String patientName;
  const PatientReport(
      {super.key, required this.patientID, required this.patientName});

  @override
  State<PatientReport> createState() => _PatientReportState();
}

class _PatientReportState extends State<PatientReport> {
  bool isDataAvaliable = false;
  bool showGraph = false;
  List<double> data = [];
  double avgImprovement = 0.2;
  double averageImprovment = 0;
  String muscleSelectedGroup = "Bicep";
  String duration = "Day";

  getAvgMuscleData() async {
    var tempData = await getAverageMuscleData(
        widget.patientID, muscleSelectedGroup, duration.toLowerCase()[0]);

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
      averageImprovment = 0;
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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('Select Muscle',
          style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
      const SizedBox(height: 20),
      SlidingButtons(
        function: slidingMuscleButtons,
        elements: {
          0: Image.asset('lib/icons/bicep.png'),
          1: Image.asset('lib/icons/calf.png'),
          2: Image.asset('lib/icons/forearm.png'),
          3: Image.asset('lib/icons/thigh.png')
        },
      ),
      const SizedBox(height: 20),
      SlidingButtons(
        function: slidingDurationButtons,
        elements: {
          0: Image.asset('lib/icons/day.png'),
          1: Image.asset('lib/icons/week.png'),
          2: Image.asset('lib/icons/month.png'),
          3: Image.asset('lib/icons/year.png')
        },
      ),
      const SizedBox(height: 20),
      PatientCondition(
        data: data,
        patientName: widget.patientName,
        muscleName: muscleSelectedGroup,
        duration: duration,
      )
    ]);
  }
}
