import 'package:firebasepractise/globals/loading.dart';
import 'package:firebasepractise/models/user.dart';
import 'package:firebasepractise/services/auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthService _authService = AuthService();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String error = '';
  bool load = false;
  @override
  Widget build(BuildContext context) {
    return (load) ? Loading() : Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(0.6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: TextFormField(
                      validator: (val) =>
                      val.isEmpty ? "Email can not be empty" : null,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                      decoration: InputDecoration.collapsed(
                        hintText: "Email",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.white.withOpacity(0.6),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal:15.0),
                    child: TextFormField(
                      validator: (val) =>
                      val.length < 6 ? "Password is weak" : null,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                      obscureText: true,
                      decoration: InputDecoration.collapsed(
                        hintText: "Password",
                        hintStyle: TextStyle(
                          color: Colors.black.withOpacity(0.3),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                FlatButton(
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      setState(() {
                        load = true;
                      });
                      dynamic user = await _authService.RegisterEmailPass(
                        email: email,
                        password: password,
                      );
                      if(user == null){
                        setState(() {
                          error = "Error Sign Up";
                          load = false;
                        });
                      }
                    }
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.red[400],
                ),
                SizedBox(height: 20,),
                Text(
                  error,
                  style: TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
