import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  final void Function({@required bool isLogin,@required String email,@required String username,@required String password,
      @required BuildContext ctx}) _submitAuthForm;
  bool _isLoading;
  AuthForm(this._submitAuthForm, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  bool _isLogin = false;
  String _email = "";
  String _username = "";
  String _password = "";
  

  void _submit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if(isValid){
      _formKey.currentState.save();
      widget._submitAuthForm(
        email: _email.trim(),
        isLogin: _isLogin,
        password: _password.trim(),
        username:_username.trim(),
        ctx:context,
      );
      
      
      print(_email);
      print(_password);
      print(_username);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 8.0,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (val) {
                      if (val.isEmpty ) {
                        return "please enter credentials";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Email"),
                    keyboardType: TextInputType.emailAddress,
                    onSaved: (val) => _email = val,
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('username'),
                      validator: (val) {
                        if (val.isEmpty || val.length < 5) {
                          return "please enter at least 5 character";
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: "Username"),
                      keyboardType: TextInputType.name,
                      onSaved: (val) => _username = val,
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (val) {
                      if (val.isEmpty || val.length < 7) {
                        return "please enter at least 8 character";
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: "Password"),
                    obscureText: true,
                    onSaved: (val) => _password = val,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(widget._isLoading) CircularProgressIndicator(),
                  if(!widget._isLoading)
                  RaisedButton(
                    child: Text(_isLogin ? 'LOGIN' : 'Sign Up'),
                    onPressed: _submit,
                  ),
                  if(!widget._isLoading)
                  FlatButton(
                    child: Text(_isLogin? "Create new account" : "I already have account"),
                    onPressed: (){
                      setState(() {
                        _isLogin =! _isLogin; 
                      });
                    },
                    textColor: Theme.of(context).primaryColor,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
