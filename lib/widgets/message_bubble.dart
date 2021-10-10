import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MessageBubble extends StatelessWidget {
  final bool isSender;
  final String text;
  final String sender;

  MessageBubble({
    this.isSender,
    this.text,
    this.sender,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            sender,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            borderRadius: isSender
                ? const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            )
                : const BorderRadius.only(
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
            elevation: 5.0,
            color: isSender ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0,
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isSender ? Colors.white : Colors.black54,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
