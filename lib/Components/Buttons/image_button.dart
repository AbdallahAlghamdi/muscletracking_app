import 'package:flutter/material.dart';

class ImageButtonA extends StatelessWidget {
  final String imageSrc;
  final VoidCallback functionPassed;
  const ImageButtonA(
      {super.key, required this.imageSrc, required this.functionPassed});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: InkWell(
        onTap: functionPassed, // Handle your callback.
        splashColor: Colors.brown.withOpacity(0.5),
        child: Ink(
          height: 135,
          width: 135,
          decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(imageSrc),
                fit: BoxFit.cover,
              ),
              border: Border.all(
                  width: 3, color: const Color.fromARGB(255, 204, 204, 204)),
              borderRadius: const BorderRadius.all(Radius.circular(20))),
        ),
      ),
    );
  }
}
