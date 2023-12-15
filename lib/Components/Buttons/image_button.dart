import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:muscletracking_app/utils/colors.dart';

class ImageButtonA extends StatelessWidget {
  final String imageSrc;
  final VoidCallback functionPassed;
  const ImageButtonA(
      {super.key, required this.imageSrc, required this.functionPassed});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: functionPassed,
      child: Container(
        alignment: Alignment.topLeft,
        margin: const EdgeInsets.all(10),
        height: 135,
        width: 220,
        decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.4),
            borderRadius: BorderRadius.circular(3),
            border: Border.all(width: 3, color: primaryColorSelected)),
        child: ClipRRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Image.asset(
                imageSrc,
                width: 220,
                height: 135,
              ),
            ),
          ),
        ),
      ),
    );
    // return Container(
    //   margin: const EdgeInsets.all(10),
    //   child: InkWell(
    //     onTap: functionPassed, // Handle your callback.
    //     splashColor: Colors.deepPurple.withOpacity(0.5),
    //     child: Ink(
    //       height: 135,
    //       width: 200,
    //       decoration: BoxDecoration(
    //           image: DecorationImage(
    //             image: AssetImage(imageSrc),
    //             fit: BoxFit.cover,
    //           ),
    //           border: Border.all(width: 3, color: primaryColor),
    //           borderRadius: const BorderRadius.all(Radius.circular(3))),
    //     ),
    //   ),
    // );
  }
}
