import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class MessageStream extends StatelessWidget {
  final _firestore = FirebaseFirestore.instance;
  final User currentUser;

  MessageStream({this.currentUser});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: _firestore
          .collection('messages')
          .orderBy(
            'timestamp',
            descending: true,
          )
          .snapshots(),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> asyncSnapshot) {
        if (!asyncSnapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = asyncSnapshot.data.docs;
        List<MessageBubble> messageBubbles = [];
        for (var message in messages) {
          var data = message.data();
          var sender = data['sender'];
          var isSender = sender == currentUser.email;
          messageBubbles.add(
            MessageBubble(
              isSender: isSender,
              text: data['text'],
              sender: sender,
            ),
          );
        }
        return Expanded(
          child: ListView(
            reverse: true,
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 20.0,
            ),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}
