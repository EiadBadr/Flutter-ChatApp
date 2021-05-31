import 'package:ChatApp/widgets/01.auth/01.auth_form.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  
  bool isLoading = false;
  submitAuthForm(
      {@required bool isLogin,
      @required String email,
      @required String username,
      @required String password,
      @required BuildContext ctx}) async {
    UserCredential userCredential;
    String msg = "error";
    try {
      setState(() {
        isLoading = true;
      });

      if (!isLogin) {
        userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        await FirebaseFirestore.instance.collection("users").doc(userCredential.user.uid).set({
          "email": email,
          "password" :password
        });
      } else {
        userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        msg = ('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        msg = ('The account already exists for that email.');
      } else if (e.code == 'user-not-found') {
        msg = ('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        msg = ('Wrong password provided for that user.');
      }
      Scaffold.of(ctx).showSnackBar(SnackBar(
        content: Text(msg),
      ));
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(submitAuthForm, isLoading),
    );
  }
}
