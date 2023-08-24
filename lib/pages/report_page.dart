import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  something() async {
    String response =
        await rootBundle.loadString('lib/excercise_data/numbers.txt');
    setState(() {
      textFromFile = response;
    });
  }

  String textFromFile = 'dataEmpty';
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(textFromFile),
        ElevatedButton(onPressed: something, child: Text('Get Text'))
      ],
    );
  }
}


/*
const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('this is the report page'),
        Icon(Icons.area_chart_rounded)
      ],
    );
*/