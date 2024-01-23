import 'package:flutter/material.dart';

class MessageRoom extends StatefulWidget {
  final String recipientName;
  const MessageRoom({super.key, required this.recipientName});

  @override
  State<MessageRoom> createState() => _MessageRoomState();
}

class _MessageRoomState extends State<MessageRoom> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [Text("data")],
      ),
    );
  }
}
