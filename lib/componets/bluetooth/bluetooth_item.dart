import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BluetoothItem extends StatelessWidget {
  final String deviceName;
  final VoidCallback function;
  final bool connected;
  const BluetoothItem(
      {super.key,
      required this.deviceName,
      required this.function,
      required this.connected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: function,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                deviceName,
                style: const TextStyle(color: Colors.white, fontSize: 23),
                overflow: TextOverflow.clip,
                maxLines: 1,
                softWrap: false,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Icon(
                connected
                    ? FontAwesomeIcons.handshakeAngle
                    : FontAwesomeIcons.handshakeSlash,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
