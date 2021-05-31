import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  String _toSendMsg = "";
  var _controller = TextEditingController();

   _sendMessage() async {
    FocusScope.of(context).unfocus();
    final currentUser = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();

    FirebaseFirestore.instance.collection('chat').add({'text': _toSendMsg,'createdAt': Timestamp.now(),
     'username': userData['username'], 
     'userId': currentUser.uid
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      child: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(labelText: "New Message..."),
                  onChanged: (val) {
                    setState(() {
                      _toSendMsg = val;
                    });
                  },
                ),
              ),
              IconButton(
                  icon: Icon(Icons.send),
                  onPressed: _toSendMsg.trim().isEmpty ? null : _sendMessage)
            ],
          ),
          Positioned(
            // top: -10
            // left: isMe? 120 , null,
            // right: isMe?, null, 120,
            
            // child: CircleAvatar(child : Image.network(src));,
          )
        ],
      ),
    );
  }
}
