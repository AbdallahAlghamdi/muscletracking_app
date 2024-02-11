import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

// ignore: must_be_immutable
class SlidingButtons extends StatelessWidget {
  final Function(int) passedFunction;
  final Map<int, Image> elements;
  int? intialValue;
  SlidingButtons(
      {super.key,
      required this.passedFunction,
      required this.elements,
      this.intialValue});

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      innerPadding: const EdgeInsets.all(5),
      isStretch: true,
      initialValue: intialValue,
      children: elements,
      onValueChanged: passedFunction,
      decoration: BoxDecoration(
          color: Colors.deepPurpleAccent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 2, color: Colors.deepPurpleAccent)),
      duration: const Duration(milliseconds: 300),
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
