import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebasepractise/models/brew.dart';
import 'package:firebasepractise/models/user.dart';

class Database{
  final String uid;
  Database({this.uid});
  final CollectionReference brewCollection = Firestore.instance.collection("brew");
  Future updateUserData({String sugars, String name, int strength}) async{
    return await brewCollection.document(uid).setData({
      'sugars': sugars,
      'name': name,
      'strength': strength,
    });
  }

  List<Brew> _brewListFromDatabase(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return Brew(
        name: doc.data['name'] ?? '',
        sugars: doc.data['sugars'
            ] ?? '0',
        strength: doc.data['strength'] ?? 0,
      );
    }).toList();
  }

  Stream<List<Brew>> get brews{
    return brewCollection.snapshots().map(_brewListFromDatabase);
  }

  Stream<UserData> get userData{
    return brewCollection.document(uid).snapshots()
    .map(_userDataFromSnapShots);
  }

  UserData _userDataFromSnapShots(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      sugars: snapshot.data['sugars'],
      strength: snapshot.data['strength'],
    );
  }

}