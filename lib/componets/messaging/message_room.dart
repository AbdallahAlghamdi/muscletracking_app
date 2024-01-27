import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:flutter/material.dart';

class MessageRoom extends StatefulWidget {
  final String recipientName;
  final int recipientID;
  const MessageRoom(
      {super.key, required this.recipientName, required this.recipientID});

  @override
  State<MessageRoom> createState() => _MessageRoomState();
}

List<Widget> messages = [];

class _MessageRoomState extends State<MessageRoom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          widget.recipientName,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: messages,
            ),
          ),
          MessageBar(
            onSend: (_) => print(_),
          ),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
