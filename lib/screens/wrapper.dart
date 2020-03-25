import 'package:firebasepractise/models/user.dart';
import 'package:firebasepractise/screens/authenticate/authenticate.dart';
import 'package:firebasepractise/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    return (user == null) ? Authenticate() : Home();
  }
}
