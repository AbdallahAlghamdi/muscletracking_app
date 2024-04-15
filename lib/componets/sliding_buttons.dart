import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';

class SlidingButtons extends StatelessWidget {
  final Function(int)
      function; //passed function, sends the index of the selected icon
  final Map<int, Image>
      elements; //map that corrospond an integer to an image (for icon)
  final int? intialValue; //initial place for the sliding button. Optional
  const SlidingButtons(
      {super.key,
      required this.function,
      required this.elements,
      this.intialValue});

  @override
  Widget build(BuildContext context) {
    return CustomSlidingSegmentedControl<int>(
      innerPadding: const EdgeInsets.all(5),
      isStretch: true,
      initialValue: intialValue,
      children: elements,
      onValueChanged: function,
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
