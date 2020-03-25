import 'package:firebasepractise/models/user.dart';
import 'package:firebasepractise/screens/wrapper.dart';
import 'package:firebasepractise/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        title: 'Firebase Practise',
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
      ),
    );
  }
}
