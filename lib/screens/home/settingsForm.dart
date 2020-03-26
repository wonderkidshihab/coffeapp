import 'package:firebasepractise/globals/loading.dart';
import 'package:firebasepractise/models/user.dart';
import 'package:firebasepractise/services/database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> sugars = ['0', '1', '2', '3', '4'];

  String _currentName;
  String _currentSugars;
  int _currentStrength;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return StreamBuilder<UserData>(
        stream: Database(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData = snapshot.data;
          return (snapshot.hasData)
              ? Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 50),
                    child: Container(
                      child: Column(
                        children: <Widget>[
                          Text(
                            "Update your data",
                            style: TextStyle(
                                color: Colors.red.withOpacity(0.75),
                                fontSize: 20,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              color: Colors.red[100],
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15.0),
                              child: TextFormField(
                                initialValue: userData.name,
                                validator: (val) => val.isEmpty
                                    ? "Name can not be Empty"
                                    : null,
                                onChanged: (val) {
                                  setState(() {
                                    _currentName = val;
                                  });
                                },
                                decoration: InputDecoration.collapsed(
                                  hintText: "Your name",
                                  hintStyle: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          DropdownButtonFormField(
                              decoration: InputDecoration.collapsed(
                                hintText: "Your sugars",
                                hintStyle: TextStyle(
                                  color: Colors.black.withOpacity(0.4),
                                ),
                              ),
                              value: _currentSugars ?? userData.sugars,
                              items: sugars.map((sugar) {
                                return DropdownMenuItem(
                                    value: sugar, child: Text("$sugar sugars"));
                              }).toList(),
                              onChanged: (val) {
                                setState(() {
                                  _currentSugars = val;
                                });
                              }),
                          SizedBox(
                            height: 20,
                          ),
                          Slider.adaptive(
                              min: 100,
                              max: 900,
                              divisions: 8,
                              activeColor: Colors
                                  .red[_currentStrength ?? userData.strength],
                              value: (_currentStrength ?? userData.strength)
                                  .toDouble(),
                              onChanged: (strength) {
                                setState(() {
                                  _currentStrength = strength.round();
                                });
                              }),
                          FlatButton(
                            color: Colors.red[400],
                            onPressed: () async {
                              if(_formKey.currentState.validate()){
                                try{
                                 await Database(uid: user.uid).updateUserData(
                                    name: _currentName ?? userData.name,
                                    sugars: _currentSugars ?? userData.sugars,
                                    strength: _currentStrength ?? userData.strength,
                                  );
                                  Navigator.pop(context);
                                } catch(e){
                                  print("Failer");
                                }
                              }
                            },
                            child: Text(
                              "Update",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : Loading();
        });
  }
}
