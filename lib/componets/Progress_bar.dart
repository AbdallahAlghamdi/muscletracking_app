import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double part;
  final int colorIndex;
  final List<List<Color>> colors = const [
    [Color(0xff0974f1), Color(0xff9fccfa)]
  ];
  const ProgressBar({super.key, required this.part, required this.colorIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
              border: Border.all(width: 3),
              borderRadius: BorderRadius.circular(10)),
          padding: EdgeInsets.all(5),
          child: Image.asset(
            "lib/icons/bicep.png",
            width: 45,
          ),
        ),
        SizedBox(width: 25),
        Container(
          width: 250,
          height: 50,
          decoration: BoxDecoration(
              color: Color.fromARGB(26, 113, 112, 112),
              border: Border.all(width: 3),
              borderRadius: BorderRadius.circular(10)),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 250 * part,
              height: 50,
              decoration: BoxDecoration(
                // color: Color.fromARGB(255, 179, 100, 100),
                gradient: LinearGradient(
                  colors: colors[colorIndex],
                ),
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
