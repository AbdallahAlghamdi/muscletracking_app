import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';

import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:muscletracking_app/componets/graph_dart.dart';
import 'package:muscletracking_app/componets/patient_condition.dart';
import 'package:muscletracking_app/componets/sliding_buttons.dart';
import 'package:muscletracking_app/pages/detailed_report.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  void initState() {
    print('initstate');
    getCurrentAccountType();
    getAvgData();

    // TODO: implement initState
    super.initState();
  }

  void averageImprovement() {
    print("entered");
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

  getAvgData() async {
    var url = Uri.http('cherubim-w8yy2.ondigitalocean.app',
        'getavg/555/${muscleSelectedGroup.toUpperCase()}');
    try {
      var response = await http.get(url);
      if (response.statusCode == 401) {
        if (mounted) {
          setState(() {
            isErrorData = true;
          });
        }
        return;
      }
      print(response.body);
      var body = jsonDecode(response.body);
      for (var word in body) {
        setState(() {
          data.add(word['average_data']);
        });
        if (mounted) {
          setState(() {
            isErrorData = false;
            isDetails = true;
          });
        }
      }
      averageImprovement();
      return;
    } on SocketException {
      print("no internet");
      setState(() {
        isNotConnected = true;
      });
    }
  }

  goToDetails() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => DetailedReport(
                muscleGroup: muscleSelectedGroup,
                accountNumber: 555,
              )),
    );
  }

  slidingButtonFunction(int index) {
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
    setState(() {
      if (mounted) {
        data = [];
      }
      averageImprovment = -1;
      isNotConnected = false;
      isErrorData = false;
      muscleSelectedGroup;
      isDetails = false;
    });
    getAvgData();
  }

  void getCurrentAccountType() async {
    print("getting account type");
    final SharedPreferences userPreferences =
        await SharedPreferences.getInstance();

    String accountType = userPreferences.get('account_type').toString();
    if (accountType == 'Patient') {
      isPatient = true;
      showGraph = false;
    } else {
      showGraph = true;
      isPatient = false;
    }
  }

  //---Variables--
  bool isErrorData = false;
  bool isNotConnected = false;
  bool isDetails = false;
  bool isPatient = false;
  List<double> data = [];
  String muscleSelectedGroup = "Bicep";
  bool showGraph = false;
  double averageImprovment = 0;
  //-------------

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
          width: 270,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            const SizedBox(height: 20),
            Text('Select muscle group',
                style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
            const SizedBox(height: 20),
            SlidingButtons(
              passedFunction: slidingButtonFunction,
              elements: {
                0: Image.asset('lib/icons/bicep.png'),
                1: Image.asset('lib/icons/leg.png'),
                2: Image.asset('lib/icons/forearm.png'),
                3: Image.asset('lib/icons/quad.png')
              },
            ),
            const SizedBox(height: 20),
            Text(
              muscleSelectedGroup,
              style: GoogleFonts.abel(fontSize: 27, color: Colors.black),
            ),
            Visibility(
              visible: showGraph,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  GraphData(data: data),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Visibility(
            //   visible: isErrorData && !isPatient,
            //   child: const TextIcon(
            //       text: 'Error, No data found',
            //       icon: UniconsLine.file_question_alt),
            // ),
            // Visibility(
            //   visible: isNotConnected,
            //   child: const TextIcon(
            //       text: 'Error, No internet', icon: UniconsLine.wifi_slash),
            // ),
            Visibility(
              visible: isDetails && showGraph,
              child: TextButton(
                  style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll<Color>(
                          Colors.deepPurpleAccent)),
                  onPressed: goToDetails,
                  child: const Text(
                    'More details',
                    style: TextStyle(color: Colors.white),
                  )),
            ),
            Visibility(
                visible: isPatient,
                child: PatientCondition(avgImprovement: averageImprovment))
          ])),
    );
  }
}
// isPatient ? ReportPatientView() : ReportPhysicianPage()