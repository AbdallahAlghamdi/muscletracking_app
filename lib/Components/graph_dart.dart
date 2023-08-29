import 'package:flutter/material.dart';
import 'package:chart_sparkline/chart_sparkline.dart';

class GraphData extends StatelessWidget {
  final List<double> data;
  const GraphData({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300.0,
        height: 200.0,
        child: Sparkline(
          pointsMode: PointsMode.all,
          data: data,
          useCubicSmoothing: true,
          cubicSmoothingFactor: 0.2,
          enableGridLines: true,
          gridLineAmount: 7,
          gridLineWidth: 1,
          gridLineColor: Colors.grey,
        ));
  }
}
