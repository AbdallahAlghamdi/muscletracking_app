import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final Text text;
  final IconData icon;
  const TextIcon({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        text,
        const SizedBox(width: 10),
        Icon(
          icon,
          color: Colors.white,
        )
      ],
    );
  }
}
