import 'package:comics_app/repository/auth.dart';
import 'package:comics_app/screen/home.dart';
import 'package:comics_app/screen/registration.dart';
import 'package:comics_app/screen/verify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;
  AuthService _authService = new AuthService();
  //Users _user = Users();

  // void initState() {
  //   AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  //   _authService.initializeCurrentUser(authNotifier);
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text('SignIn'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
              onChanged: (value) {
                setState(() {
                  // _user.email = value.trim();
                  _email = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(hintText: 'Password'),
              onChanged: (value) {
                setState(() {
                  //_user.password = value.trim();
                  _password = value.trim();
                });
              },
            ),

          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:[
                RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Signin'),
                    onPressed: (){
                      // _authService.login(_email, _password).then((curUser){
                      //   User currentUser = curUser;
                      //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(curUser)));
                      // });
                      auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                        // _user.email = _email;
                        // _user.password = _password;
                        // _user.displayName = FirebaseAuth.instance.currentUser.displayName;
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomeScreen(auth.currentUser.displayName)));
                      });
                    }),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Signup'),
                  onPressed: (){
                    //auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => RegistrationScreen()));
//                    });

                  },
                ),
              ])
        ],),
    );
  }
}