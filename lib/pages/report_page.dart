import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:muscletracking_app/Components/graph_dart.dart';
import 'package:muscletracking_app/Components/sliding_buttons.dart';
import 'package:http/http.dart' as http;
import 'package:muscletracking_app/Components/text_icon.dart';
import 'package:muscletracking_app/pages/detailed_report.dart';
import 'package:unicons/unicons.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  //----Functions
  getAvgData() async {
    var url = Uri.http(
        '127.0.0.1:5000', 'getavg/555/${muscleSelectedGroup.toUpperCase()}');
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
      isNotConnected = false;
      isErrorData = false;
      muscleSelectedGroup;
      isDetails = false;
    });
    getAvgData();
  }

  @override
  void initState() {
    print('initstate');
    getAvgData();
    // TODO: implement initState
    super.initState();
  }

  //---Variables--
  bool isErrorData = false;
  bool isNotConnected = false;
  bool isDetails = false;
  List<double> data = [];
  String muscleSelectedGroup = "Bicep";
  //-------------
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(height: 20),
        const Text('Select muscle group'),
        const SizedBox(height: 20),
        SlidingButtons(passedFunction: slidingButtonFunction),
        const SizedBox(height: 20),
        Text(muscleSelectedGroup),
        const SizedBox(height: 20),
        GraphData(data: data),
        const SizedBox(height: 20),
        Visibility(
          visible: isErrorData,
          child: const TextIcon(
              text: 'Error, No data found',
              icon: UniconsLine.file_question_alt),
        ),
        Visibility(
          visible: isNotConnected,
          child: const TextIcon(
              text: 'Error, No internet', icon: UniconsLine.wifi_slash),
        ),
        Visibility(
          visible: isDetails,
          child: ElevatedButton(
              onPressed: goToDetails, child: const Text('more details')),
        ),
      ]),
    );
  }
}
