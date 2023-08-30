import 'dart:convert';
import 'dart:ffi';

import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:muscletracking_app/Components/graph_dart.dart';
import 'package:unicons/unicons.dart';

class DetailedReport extends StatefulWidget {
  final String muscleGroup;
  final int accountNumber;

  const DetailedReport(
      {super.key, required this.muscleGroup, required this.accountNumber});

  @override
  State<DetailedReport> createState() => _DetailedReportState();
}

class _DetailedReportState extends State<DetailedReport> {
  getIcon() {
    switch (widget.muscleGroup.toUpperCase()) {
      case "THIGH":
        return Image.asset('lib/icons/quad.png', height: 35);
      case "CALF":
        return Image.asset('lib/icons/leg.png', height: 35);
      case "BICEP":
        return Image.asset('lib/icons/bicep.png', height: 35);
      case "FOREARM":
        return Image.asset('lib/icons/forearm.png', height: 35);
    }
  }

  getExcerciseID() async {
    int accountNumber = widget.accountNumber;
    String muscleGroup = widget.muscleGroup.toUpperCase();
    var url = Uri.http(
        '127.0.0.1:5000', 'getExcerciseID/$accountNumber/$muscleGroup');
    var response = await http.get(url);
    print('getExcerciseID/$accountNumber/$muscleGroup');
    var body = jsonDecode(response.body);
    print(body[0]);
    for (var word in body) {
      print(word['_id']);
      setState(() {
        items.add(CoolDropdownItem(
            icon: const Icon(UniconsLine.heart_alt),
            selectedIcon: const Icon(FontAwesomeIcons.heartCircleBolt),
            label: 'Exercise No. ${word['_id']}',
            value: "${word['_id']}"));
      });
    }
  }

  populateGraph(int exerciseNumber) async {
    int accountNumber = widget.accountNumber;
    var url = Uri.http('127.0.0.1:5000', 'getDetailExercise/$exerciseNumber');
    var response = await http.get(url);
    var body = jsonDecode(response.body);
    print(body[0]);
    for (var word in body) {
      print(word['value']);
      setState(() {
        data.add(word['value']);
      });
    }
  }

  DropdownController contrl =
      DropdownController(duration: const Duration(milliseconds: 0));
  List<CoolDropdownItem<String>> items = [];
  List<double> data = [];
  @override
  void initState() {
    print(widget.accountNumber);
    print(widget.muscleGroup);
    getExcerciseID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [getIcon()],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("data"),
            CoolDropdown(
                dropdownList: items,
                controller: contrl,
                dropdownItemOptions: const DropdownItemOptions(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween),
                onChange: (String s) {
                  contrl.close();
                  data = [];
                  populateGraph(int.parse(s));
                }),
            const SizedBox(height: 35),
            GraphData(data: data),
          ],
        ),
      ),
    );
  }
}
