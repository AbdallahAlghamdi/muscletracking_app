import 'package:cool_dropdown/models/cool_dropdown_item.dart';
import 'package:flutter/material.dart';
import 'package:cool_dropdown/cool_dropdown.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:muscletracking_app/componets/graph_dart.dart';
import 'package:muscletracking_app/componets/sliding_buttons.dart';
import 'package:muscletracking_app/componets/online/database.dart';
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
  DropdownController contrl =
      DropdownController(duration: const Duration(milliseconds: 0));
  List<CoolDropdownItem<String>> items = [];
  List<double> data = [];
  bool showGraph = false;

  String duration = 'd';
  getExcerciseID() async {
    print("Started");
    List<int> tempData = [];
    tempData =
        await getExerciseID(widget.accountNumber, widget.muscleGroup, duration);

    for (var word in tempData) {
      setState(() {
        items.add(CoolDropdownItem(
            icon: const Icon(UniconsLine.heart_alt),
            selectedIcon: const Icon(FontAwesomeIcons.heartCircleBolt),
            label: 'Exercise No. $word',
            value: "$word"));
      });
    }
    print("closed");
  }

  slidingDurationButtons(int index) {
    setState(() {
      items = [];
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
    getExcerciseID();
  }

  getIcon() {
    switch (widget.muscleGroup.toUpperCase()) {
      case "THIGH":
        return Image.asset('lib/icons/thigh.png', height: 35);
      case "CALF":
        return Image.asset('lib/icons/calf.png', height: 35);
      case "BICEP":
        return Image.asset('lib/icons/bicep.png', height: 35);
      case "FOREARM":
        return Image.asset('lib/icons/forearm.png', height: 35);
    }
  }

  populateGraph(int exerciseNumber) async {
    var tempData = await getDetailedExercise(exerciseNumber);
    setState(() {
      showGraph = true;
      data = tempData;
    });
    // var url = Uri.http('cherubim-w8yy2.ondigitalocean.app',
    //     'getDetailExercise/$exerciseNumber');
    // var response = await http.get(url);
    // var body = jsonDecode(response.body);
    // print(body[0]);
    // for (var word in body) {
    //   print(word['value']);
    //   int val = word['value'];
    //   setState(() {
    //     data.add(val.toDouble());
    //   });
    // }
  }

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
        backgroundColor: Colors.deepPurpleAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [getIcon()],
        ),
      ),
      body: Center(
        child: SafeArea(
          child: SizedBox(
            width: 270,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlidingButtons(
                  passedFunction: slidingDurationButtons,
                  elements: {
                    0: Image.asset('lib/icons/day.png'),
                    1: Image.asset('lib/icons/week.png'),
                    2: Image.asset('lib/icons/month.png'),
                    3: Image.asset('lib/icons/year.png')
                  },
                ),
                SizedBox(height: 20),
                CoolDropdown(
                    dropdownList: items,
                    controller: contrl,
                    dropdownItemOptions: const DropdownItemOptions(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween),
                    onChange: (String s) {
                      data = [];
                      contrl.close();

                      showGraph = true;
                      populateGraph(int.parse(s));
                    }),
                const SizedBox(height: 35),
                Visibility(visible: showGraph, child: GraphData(data: data)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
