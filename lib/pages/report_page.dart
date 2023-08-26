import 'package:flutter/material.dart';
import 'package:muscletracking_app/Components/sliding_buttons.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const SizedBox(height: 20),
        const Text('Select muscle group'),
        const SizedBox(height: 20),
        SlidingButtons(passedFunction: (int a) {})
      ]),
    );
  }
}
