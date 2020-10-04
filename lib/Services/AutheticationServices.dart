import 'package:firebase_auth/firebase_auth.dart';
import 'package:userprofile_demo/DatabaseManager/DatabaseManager.dart';

class AuthenticationServices{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Register with email & Password
  Future createNewUser(String name, String email, String password) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    FirebaseUser user = result.user;
    await DatabaseManager().createUserData(name, 'Male', 100, user.uid);
    return user;
    }catch(e){
      print(e.toString());
    }
  }

  //SignIn With email & password
  Future signInUser(String email, String password) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      return result.user;
    }catch(e){
      print(e.toString());
    }
  }

  //signout
  Future signOut(){
    try{
      return _auth.signOut();
    }catch(error){
      print(error.toString());
      return null;
    }
  }
}