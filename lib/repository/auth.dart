import 'package:comics_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:comics_app/utils/auth_notifier.dart';
import 'package:comics_app/screen/verify.dart';
class AuthService {

  //AuthNotifier authNotifier = new AuthNotifier();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Users _userValidateFromFirebase(User user) {
      return user !=null ? Users(uid: user.uid): null;
  }

  Stream<Users> get user{
     return _auth.onAuthStateChanged.map(_userValidateFromFirebase);
  }

  Future<String> getCurrentUID() async {
    return (await _auth.currentUser).uid;
  }
//
//   Future signInWithEmailAndPassword(String email, String pwd) async{
//     try{
//       UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: pwd);
//       User user = result.user;
//       if(user != null) {
//         await FirebaseAuth.instance.currentUser.updateProfile(
//             displayName: user.displayName);
//         authNotifier.setUser(user);
//       }
//         return user;
//     }
//     catch(e){
//       print(e.toString());
//       return null;
//     }
//   }
//
//   Future registerWithEmailAndPassword(String email, String pwd, String displayName) async{
//     try{
//       UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: pwd);
//       User user = result.user;
//       if(user != null) {
//         await FirebaseAuth.instance.currentUser.updateProfile(
//             displayName: displayName);
//         authNotifier.setUser(user);
//       }
//       return user;
//     }
//     catch(e){
//       print(e.toString());
//       return null;
//     }
//   }
//
  Future signOut() async{
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }
// }

  login(String email, String password) async {
    UserCredential authResult = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .catchError((error) => print(error.code));

    if (authResult != null) {
      User firebaseUser = authResult.user;

      if (firebaseUser != null) {
        print("Log In: $firebaseUser");
        //authNotifier.setUser(firebaseUser);
      }
      return FirebaseAuth.instance.currentUser;
    }
  }

  signup(String email, String password, String displayName) async {
    UserCredential authResult = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
        email: email, password: password)
        .catchError((error) => print(error.code));

    if (authResult != null) {
      User firebaseUser = authResult.user;

      if (firebaseUser != null) {
        await FirebaseAuth.instance.currentUser.updateProfile(
            displayName: displayName);

        await firebaseUser.reload();

        print("Sign up: $firebaseUser");

        User currentUser = await FirebaseAuth.instance.currentUser;
        return currentUser;
        //VerifyScreen(currentUser);
      }
    }
  }

  // signout(AuthNotifier authNotifier) async {
  //   await FirebaseAuth.instance.signOut().catchError((error) =>
  //       print(error.code));
  //
  //   authNotifier.setUser(null);
  // }

  // initializeCurrentUser(AuthNotifier authNotifier) async {
  //   User firebaseUser = await FirebaseAuth.instance.currentUser;
  //
  //   if (firebaseUser != null) {
  //     print(firebaseUser);
  //     authNotifier.setUser(firebaseUser);
  //   }
  // }
}
