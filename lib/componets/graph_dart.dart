import 'package:flutter/material.dart';
import 'package:chart_sparkline/chart_sparkline.dart';

class GraphData extends StatelessWidget {
  final List<double> data;
  const GraphData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: 300.0,
        height: 200.0,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(width: 6, color: Colors.deepPurpleAccent),
        ),
        child: Sparkline(
          lineColor: Colors.deepPurpleAccent,
          pointsMode: PointsMode.all,
          data: data,
          useCubicSmoothing: true,
          cubicSmoothingFactor: 0.2,
          enableGridLines: true,
          gridLineAmount: 9,
          gridLineWidth: 2,
          gridLineColor: Colors.grey,
        ));
  }
}
