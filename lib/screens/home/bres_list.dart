import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasepractise/models/brew.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BrewList extends StatefulWidget {
  @override
  _BrewListState createState() => _BrewListState();
}

class _BrewListState extends State<BrewList> {
  @override
  Widget build(BuildContext context) {
    final brews = Provider.of<List<Brew>>(context) ?? [];
    return ListView.builder(
      itemCount: brews.length,
        itemBuilder: (context, index){
        Brew brew = brews[index];
          return Card(
            margin: EdgeInsets.only(top: 20, left: 10, right: 10),
            elevation: 1,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.red[brew.strength],
                ),
                title: Text(brew.name),
                subtitle: Text("Takes ${brew.sugars} sugar(s)"),
              ),
            ),
          );
    });
  }
}
