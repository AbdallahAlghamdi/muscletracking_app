import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:muscletracking_app/Components/sliding_buttons.dart';
import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:muscletracking_app/Components/text_icon.dart';
import 'package:unicons/unicons.dart';
import 'package:win_toast/win_toast.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  getAvgData() async {
    var url = Uri.http(
        '127.0.0.1:5000', 'getavg/555/${muscleSelectedGroup.toUpperCase()}');
    var response = await http.get(url);
    print('getavg/555/${muscleSelectedGroup.toUpperCase()}');
    //print('Response status: ${response.statusCode}');
    //print('Response body: ${response.body}');
    var body = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 401) {
      if (mounted) {
        setState(() {
          isError = true;
        });
      }

      return;
    }
    for (var word in body) {
      setState(() {
        data.add(word['average_data']);
      });
      if (mounted) {
        setState(() {
          isError = true;
        });
      }
    }
  }

  @override
  void initState() {
    print('initstate');
    getAvgData();
    // TODO: implement initState
    super.initState();
  }

  bool isError = false;
  List<double> data = [];
  String muscleSelectedGroup = "Bicep";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(height: 20),
        const Text('Select muscle group'),
        const SizedBox(height: 20),
        SlidingButtons(passedFunction: (int index) {
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
            isError = false;
            muscleSelectedGroup;
          });
          getAvgData();
        }),
        const SizedBox(height: 20),
        Text(muscleSelectedGroup),
        const SizedBox(height: 20),
        SizedBox(
            width: 300.0,
            height: 200.0,
            child: Sparkline(
              pointsMode: PointsMode.all,
              data: data,
              averageLine: true,
              useCubicSmoothing: true,
              cubicSmoothingFactor: 0.2,
              enableGridLines: true,
            )),
        SizedBox(height: 20),
        Visibility(
          visible: isError,
          child: const TextIcon(
              text: 'Error, No data found',
              icon: UniconsLine.file_question_alt),
        )
      ]),
    );
  }
}
