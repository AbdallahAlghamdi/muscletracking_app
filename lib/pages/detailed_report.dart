import 'dart:convert';

import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:http/http.dart' as http;

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

  @override
  Widget build(BuildContext context) {
    DropdownController contrl =
        DropdownController(duration: const Duration(milliseconds: 400));
    List<CoolDropdownItem<Widget>> items = List.empty();

    getExcerciseID() async {
      var url = Uri.http('127.0.0.1:5000',
          'getExcerciseID/$widget.accountNumber/${widget.muscleGroup}');
      var response = await http.get(url);
      var body = jsonDecode(response.body);

      for (var word in body) {
        setState(() {
          items.add(
              CoolDropdownItem(label: word['_id'], value: Icon(Icons.abc)));
        });
      }
    }

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
            Text("data"),
            CoolDropdown(
                dropdownList: items,
                controller: contrl,
                onChange: (Widget s) {})
          ],
        ),
      ),
    );
  }
}
