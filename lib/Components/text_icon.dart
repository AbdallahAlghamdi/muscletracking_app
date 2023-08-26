import 'package:flutter/material.dart';

class TextIcon extends StatelessWidget {
  final String text;
  final Widget icon;
  TextIcon({super.key, required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyLarge,
        children: [
          TextSpan(text: text),
          WidgetSpan(
            child:
                Padding(padding: const EdgeInsets.only(left: 7), child: icon),
          ),
        ],
      ),
    );
  }
}
