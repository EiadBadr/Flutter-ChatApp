import 'package:ChatApp/widgets/02.chat/01.messages.dart';
import 'package:ChatApp/widgets/02.chat/02.new_message.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat App"),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                  value: "logout",
                  child: Row(
                    children: [
                      Text("Logout"),
                      SizedBox(
                        width: 15,
                      ),
                      Icon(Icons.exit_to_app)
                    ],
                  )),
            ],
            onChanged: (val) {
              if (val == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(child: Messages()),
            NewMessages(),
          ],
        ),
      ),
    );
  }
}
