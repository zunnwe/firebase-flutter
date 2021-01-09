import 'package:comics_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  Users _userValidateFromFirebase(User user) {
      return user !=null ? Users(uid: user.uid): null;
  }

  Stream<Users> get user{
     return _auth.onAuthStateChanged.map(_userValidateFromFirebase);
  }

  Future signInWithEmailAndPassword(String email, String pwd) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
      User user = result.user;
      await FirebaseAuth.instance.currentUser.updateProfile(displayName:user.displayName);
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String pwd) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: pwd);
      User user = result.user;
      await FirebaseAuth.instance.currentUser.updateProfile(displayName:user.displayName);
      return user;
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
}