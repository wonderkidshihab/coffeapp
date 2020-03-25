import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasepractise/models/user.dart';

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
      print(e.toString());
      return null;
    }
  }

  Future SignOut() async{
    try{
    return await _auth.signOut();
  } catch(e){
      print("${e.toString()} Can not Sign Out");
    }
  }
}