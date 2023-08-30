import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class SlidingButtons extends StatelessWidget {
  final Function(int) passedFunction;
  const SlidingButtons({super.key, required this.passedFunction});

  @override
  Widget build(BuildContext context) {
    const double iconSize = 35;
    return CustomSlidingSegmentedControl<int>(
      initialValue: 0,
      children: {
        0: Image.asset('lib/icons/bicep.png',
            height: iconSize, isAntiAlias: true),
        1: Image.asset('lib/icons/leg.png',
            height: iconSize, isAntiAlias: true),
        2: Image.asset('lib/icons/forearm.png',
            height: iconSize, isAntiAlias: true),
        3: Image.asset('lib/icons/quad.png',
            height: iconSize, isAntiAlias: true),
      },
      onValueChanged: passedFunction,
      decoration: BoxDecoration(
        color: Colors.deepPurpleAccent,
        borderRadius: BorderRadius.circular(8),
      ),
      thumbDecoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.3),
            blurRadius: 4.0,
            spreadRadius: 1.0,
            offset: const Offset(
              0.0,
              2.0,
            ),
          ),
        ],
      ),
    );
  }
}
