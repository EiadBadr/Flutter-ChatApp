
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '03.message_bubble.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }

          final docs = snapshot.data.docs;
          final user = FirebaseAuth.instance.currentUser;
          return ListView.builder(
              reverse: true,
              itemCount: docs.length,
              itemBuilder: (ctx, index) {
                return MessageBubble(
                  message: docs[index]['text'],
                  isMe: docs[index]['userId'] == user.uid,
                  username: docs[index]['username'],
                  key: ValueKey("teszr")
                );
              });
        });
  }
}
