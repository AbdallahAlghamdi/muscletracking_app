import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class SlidingButtons extends StatelessWidget {
  final Function(int) passedFunction;
  const SlidingButtons({super.key, required this.passedFunction});

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      initialValue: 0,
      children: {
        0: Image.asset('lib/icons/bicep.png', height: 30, width: 30),
        1: Image.asset('lib/icons/leg.png', height: 30, width: 30),
        2: Image.asset('lib/icons/forearm.png', height: 30, width: 30),
        3: Image.asset('lib/icons/quad.png', height: 30, width: 30),
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
