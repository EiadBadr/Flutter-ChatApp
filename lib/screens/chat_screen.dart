import 'package:cloud_firestore/cloud_firestore.dart';
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
                  children: [Text("Logout"),SizedBox(width: 15,), Icon(Icons.exit_to_app)],
                )),
              ],
              onChanged: (val){
                if(val == 'logout'){
                  FirebaseAuth.instance.signOut();
                }
              },
              ),            
        ],

      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("chats/97xnrXLFCTueL3OSGqVj/messages")
              .snapshots(),
          builder: (ctx_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            final docs = snapshot.data.docs;
            return ListView.builder(
              itemCount: docs.length,
              itemBuilder: (ctx, index) => Container(
                  padding: EdgeInsets.all(10),
                  child: Text(docs[index]['text'])),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection("chats/97xnrXLFCTueL3OSGqVj/messages")
              .add({'text': 'Eiadass'});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
