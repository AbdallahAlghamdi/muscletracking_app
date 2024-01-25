import 'package:cool_dropdown/controllers/dropdown_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:muscletracking_app/componets/graph_dart.dart';
import 'package:muscletracking_app/componets/patient_List.dart';
import 'package:muscletracking_app/componets/sliding_buttons.dart';
import 'package:muscletracking_app/componets/text_icon.dart';
import 'package:unicons/unicons.dart';

class PhysicianReport extends StatefulWidget {
  final Function(int) patientSelected;
  final Function(int) slidingMuscleButtons;
  final Function(int) slidingDurationButtons;
  final Function() goToDetails;
  final List<double> data;
  final DropdownController patientListController;
  final String muscleSelectedGroup;
  final bool showMuscleSlide;
  final bool showGraph;
  final bool isDataAvaliable;
  const PhysicianReport(
      {super.key,
      required this.patientSelected,
      required this.patientListController,
      required this.muscleSelectedGroup,
      required this.showMuscleSlide,
      required this.slidingMuscleButtons,
      required this.showGraph,
      required this.slidingDurationButtons,
      required this.isDataAvaliable,
      required this.goToDetails,
      required this.data});

  @override
  State<PhysicianReport> createState() => _PhysicianReportState();
}

class _PhysicianReportState extends State<PhysicianReport> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const SizedBox(height: 20),
      Text('Select Patient',
          style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
      const SizedBox(height: 20),
      PatientList(
        doctorID: 2142,
        function: widget.patientSelected,
        controller: widget.patientListController,
      ),
      const SizedBox(height: 20),
      Visibility(
        visible: widget.showMuscleSlide,
        child: Column(
          children: [
            SlidingButtons(
              passedFunction: widget.slidingMuscleButtons,
              elements: {
                0: Image.asset('lib/icons/bicep.png'),
                1: Image.asset('lib/icons/leg.png'),
                2: Image.asset('lib/icons/forearm.png'),
                3: Image.asset('lib/icons/quad.png')
              },
            ),
            const SizedBox(height: 10),
            Text(widget.muscleSelectedGroup,
                style: GoogleFonts.abel(fontSize: 27, color: Colors.black)),
            const SizedBox(height: 10),
            SlidingButtons(
              passedFunction: widget.slidingDurationButtons,
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
        visible: widget.showGraph,
        child: Column(
          children: [
            const SizedBox(height: 20),
            GraphData(data: widget.data),
            const SizedBox(height: 10),
            Visibility(
              visible: widget.isDataAvaliable,
              child: ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepPurpleAccent)),
                  onPressed: widget.goToDetails,
                  child: const TextIcon(
                      text: Text("Details",
                          style: TextStyle(color: Colors.white)),
                      icon: UniconsLine.document_info)),
            )
          ],
        ),
      ),
    ]);
  }
}
