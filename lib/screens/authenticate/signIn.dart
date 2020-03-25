import 'package:firebasepractise/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[100],
      appBar: AppBar(
        backgroundColor: Colors.red[400],
        title: Text("Firebase Practise"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () async {
            dynamic result = await _authService.SignInAnon();
            if (result != null) {
              print("Signed in Succesfully\n ");
              print(result.uid);
            } else {
              print("Error\n Can not Sign In");
            }
          },
          child: Text("Sgn In"),
        ),
      ),
    );
  }
}
