import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasepractise/models/brew.dart';
import 'package:firebasepractise/screens/home/bres_list.dart';
import 'package:firebasepractise/screens/home/settingsForm.dart';
import 'package:firebasepractise/services/auth.dart';
import 'package:firebasepractise/services/database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  void _showSettings() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          child: Center(
            child: SettingsForm(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Brew>>.value(
      value: Database().brews,
      child: Scaffold(
        backgroundColor: Colors.red[100],
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.red[400],
          title: Text("Firebase Practise"),
          actions: <Widget>[
            IconButton(
              splashColor: Colors.red[400],
              onPressed: () => _showSettings(),
              icon: Icon(
                Icons.settings,
                color: Colors.white,
              ),
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text(
                "Log Out",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                await AuthService().SignOut();
              },
            ),
          ],
        ),
        body: BrewList(),
      ),
    );
  }
}
