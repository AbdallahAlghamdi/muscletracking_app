import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:flutter/material.dart';

import 'package:muscletracking_app/online/database.dart';
import 'package:muscletracking_app/pages/detailed_report.dart';
import 'package:muscletracking_app/pages/interface/patient_report.dart';
import 'package:muscletracking_app/pages/interface/physician_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportsPage extends StatefulWidget {
  const ReportsPage({super.key});

  @override
  State<ReportsPage> createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  //-------------Variables----------
  int patientID = 0;
  double averageImprovment = 0;
  bool isPatient = true;
  bool isDataAvaliable = false;
  bool showMuscleSlide = false;
  bool isloaded = false;
  bool showGraph = false;
  String muscleSelectedGroup = "Bicep";
  String patientName = "";
  String duration = "d";
  List<double> data = [];
  var patientListController = DropdownController();
  //-----------------------------------

  patientSelected(int index) {
    patientListController.close();
    setState(() {
      patientID = index;
      showMuscleSlide = true;
      showGraph = true;
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

  getAccountType() async {
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();

    String accountType =
        await userPreferences.getString('account_type').toString();
    var accountNumber = await userPreferences.getInt('account_number');
    setState(() {
      print(accountType);
      if (accountType == 'patient') {
        isPatient = true;
        patientID = accountNumber!.toInt(); //Change this
        isloaded = true;
        getAvgMuscleData();
      } else {
        isPatient = false;
      }
    });
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

  slidingDurationButtons(int index) {
    resetData();
    setState(() {
      showGraph = true;
      switch (index) {
        case 0:
          duration = "d";
          break;
        case 1:
          duration = "w";
          break;
        case 2:
          duration = "m";
          break;
        case 3:
          duration = "y";
          break;
      }
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

  void getAverageImprovement() {
    print(data);
    if (data.length > 1) {
      double total = 0;
      for (var i = 1; i < data.length; i++) {
        print(data[i]);
        total += data[i];
      }

      double average = total / (data.length - 1);
      print("Average: $average");
      print(average / data[0]);
      setState(() {
        averageImprovment = average / data[0];
        // averageImprovment = increase / data[0];
      });
    }
  }

  getAvgMuscleData() async {
    var tempData =
        await getAverageMuscleData(patientID, muscleSelectedGroup, duration);

    if (mounted) {
      setState(() {
        data = tempData;
        if (data.isNotEmpty) {
          isDataAvaliable = true;
        }
        if (isPatient) {
          getAverageImprovement();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAccountType();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 270,
        child: Column(children: [
          const SizedBox(height: 15),
          Visibility(
            visible: !isPatient,
            child: PhysicianReport(
              goToDetails: goToDetails,
              patientSelected: patientSelected,
              slidingMuscleButtons: slidingMuscleButtons,
              slidingDurationButtons: slidingDurationButtons,
              patientListController: patientListController,
              muscleSelectedGroup: muscleSelectedGroup,
              showMuscleSlide: showMuscleSlide,
              isDataAvaliable: isDataAvaliable,
              showGraph: showGraph,
              data: data,
            ),
          ),
          Visibility(
            visible: isPatient && isloaded,
            child: PatientReport(
              slidingDurationButtons: slidingDurationButtons,
              slidingMuscleButtons: slidingDurationButtons,
              avgImprovement: averageImprovment,
            ),
          )
        ]),
      ),
    );
  }
}
