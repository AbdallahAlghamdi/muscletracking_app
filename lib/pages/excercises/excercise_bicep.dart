import 'dart:convert';
import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:muscletracking_app/Components/loading_circle.dart';
import 'package:unicons/unicons.dart';
import 'package:http/http.dart' as http;

class ExcerciseBicep extends StatefulWidget {
  const ExcerciseBicep({super.key});

  @override
  State<ExcerciseBicep> createState() => _ExcerciseBicepState();
}

class _ExcerciseBicepState extends State<ExcerciseBicep> {
  Map<String, dynamic> makeJson() {
    var numbers = [124, 212, 441];
    Map<String, dynamic> finalJson = {};

    finalJson["account_number"] = 555;
    finalJson["average_data"] = 507;
    finalJson["muscle_group"] = 'BICEP';
    finalJson["raw_data"] = numbers;
    return finalJson;
  }

  sendData() async {
    var url = Uri.http('127.0.0.1:5000', '/newExcercise');
    var response = await http.post(url,
        body: jsonEncode(makeJson()),
        headers: {"Content-Type": "application/json"});
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
  }

  loadingCircleLogic() {
    if (contrl.isPaused) {
      print('test');
      setState(() {
        iconForButton = UniconsLine.pause;
        buttonName = "Pause";
      });
      contrl.resume();
      return;
    }
    if (contrl.isStarted) {
      contrl.pause();
      setState(() {
        iconForButton = UniconsLine.forward;
        buttonName = "Continue";
      });
      return;
    }
    contrl.start();
    setState(() {
      iconForButton = UniconsLine.pause;
      buttonName = "Pause";
    });
  }

  CountDownController contrl = CountDownController();

  String buttonName = 'Start';
  int duration = 10;
  IconData iconForButton = UniconsLine.forward;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Excercising the bicep')),
      body: Center(
        child: Column(children: [
          LoadingCircle(onStart: () {}, onFinish: sendData, contrl: contrl),
          ElevatedButton.icon(
              onPressed: loadingCircleLogic,
              icon: Icon(iconForButton),
              label: Text(buttonName)),
        ]),
      ),
    );
  }
}
