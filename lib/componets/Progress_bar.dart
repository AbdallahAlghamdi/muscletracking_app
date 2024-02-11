import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double part;
  final double width = 200;
  final String muscleGroup;
  final List<List<Color>> colors = const [
    [Color(0xff12b3eb), Color(0xff5460f9)],
    [Color(0xffffb88e), Color(0xffea5753)],
    [Color(0xff12b3eb), Color.fromARGB(255, 158, 211, 228)],
  ];
  const ProgressBar({super.key, required this.part, required this.muscleGroup});

  @override
  Widget build(BuildContext context) {
    int selectedColorIndex = 0;

    if (part < 0.3) {
      selectedColorIndex = 1;
    } else if (part >= 1) {
      selectedColorIndex = 2;
    }
    return Visibility(
      visible: part > 0,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
            decoration: BoxDecoration(
                border: Border.all(
                    width: 3, color: const Color.fromARGB(255, 59, 59, 59)),
                borderRadius: BorderRadius.circular(10),
                color: const Color.fromARGB(255, 152, 151, 149)),
            padding: const EdgeInsets.all(5),
            child: Image.asset(
              "lib/icons/$muscleGroup.png",
              width: 45,
            ),
          ),
          const SizedBox(width: 25),
          Container(
            width: width,
            height: 50,
            decoration: BoxDecoration(
                color: const Color.fromARGB(9, 255, 255, 255),
                border: Border.all(
                    width: 3, color: const Color.fromARGB(255, 59, 59, 59)),
                borderRadius: BorderRadius.circular(10)),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: width * part,
                height: 50,
                decoration: BoxDecoration(
                  // color: Color.fromARGB(255, 179, 100, 100),
                  gradient: LinearGradient(
                    colors: colors[selectedColorIndex],
                  ),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
