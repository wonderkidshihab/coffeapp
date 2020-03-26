import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepractise/models/user.dart';
import 'package:firebasepractise/services/database.dart';

class AuthService{
  FirebaseAuth _auth = FirebaseAuth.instance;

  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map(_userFromFirebaseUser);
  }

  Future SignInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      return null;
    }
  }

  Future RegisterEmailPass({String email, String password}) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;

      await Database(uid: user.uid).updateUserData(sugars: '0', name: "A new User", strength: 100);

      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future SignInEmailPass({String email, String password}) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }

  Future SignOut() async{
    try{
    return await _auth.signOut();
  } catch(e){
      return null;
    }
  }
}