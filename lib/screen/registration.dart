import 'package:comics_app/repository/auth.dart';
import 'package:comics_app/screen/login.dart';
import 'package:comics_app/screen/verify.dart';
import 'package:flutter/material.dart';
import 'package:comics_app/utils/constants.dart';
import 'package:comics_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:comics_app/screen/pdfListScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:comics_app/utils/auth_notifier.dart';
//
// class RegistrationScreen extends StatelessWidget{
//   final AuthService _authService = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   String error = "";
//   @override
//   Widget build(BuildContext context) {
//     String mail;
//     String password;
//     String username;
//     // TODO: implement build
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//         body: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: <Widget>[
//             // Container(
//             //   child: Stack(
//             //     children: [
//             //       Container(
//             //         padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
//             //         child: Text(
//             //             'Hello',
//             //             style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.lightBlue)
//             //         ),
//             //       ),
//             //       Container(
//             //         padding: EdgeInsets.fromLTRB(30.0, 180.0, 0.0, 0.0),
//             //         child: Text(
//             //           'There.',
//             //           style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.lightBlue),
//             //         ),
//             //       )
//             //     ],
//             //   ),
//             // ),
//             Column(
//               children: <Widget>[
//                 Form(
//                   key: _formKey,
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         padding: EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
//                         child: TextFormField(
//                           validator: (val)=> val.isEmpty? "Enter your username" : null,
//                           style: TextStyle(color: Colors.black87),
//                           decoration: buildUsernameField,
//                           onChanged: (val){
//                             username = val;
//                           },
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
//                         child: TextFormField(
//                           validator: (val)=> val.isEmpty? "Enter your email": null,
//                           style: TextStyle(color: Colors.black87),
//                           decoration: buildEmailField,
//                           onChanged: (val){
//                             mail = val;
//                           },
//                         ),
//                       ),
//                       Container(
//                         padding: EdgeInsets.all(10.0),
//                         child: TextFormField(
//                           validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
//                           style: TextStyle(color: Colors.black87),
//                           decoration: buildPasswordField,
//                           onChanged: (val){
//                             password = val;
//                           },
//                         ),
//                       ),
//                       SizedBox(height: 12.0),
//                       Text(
//                         error,
//                         style: TextStyle(color: Colors.red, fontSize: 14.0),
//                       )
//                     ],
//                   ),
//                 ),
//               ]
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Container(
//                   padding: EdgeInsets.fromLTRB(40.0, 30.0, 0.0, 0.0),
//                   child: ButtonTheme(
//                     minWidth: 300.0,
//                     height: 30.0,
//                     child: RaisedButton(
//                       color: Colors.lightBlue,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0)
//                       ),
//                       child: Text(
//                           'Create New Account',
//                           style: TextStyle(
//                               color: Colors.white
//                           )
//                       ),
//                       onPressed: () async{
//                         if(_formKey.currentState.validate()){
//                           dynamic result = await _authService.registerWithEmailAndPassword(mail, password);
//                           if(result == null){
//                             error = 'Please supply a valid credentials';
//                           }
//                         }
//
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => VerifyScreen()),
//                         );
//                       },
//                     ),
//                   ),
//
//                 ),
//                 Container(
//                   padding: EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
//                   child: ButtonTheme(
//                     minWidth: 300.0,
//                     height: 30.0,
//                     child: RaisedButton(
//                       color: Colors.white,
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0)
//                       ),
//                       onPressed: (){
//                         Navigator.of(context).pushNamed('/signIn');
//                       },
//                       child: Text(
//                           'Login',
//                           style: TextStyle(
//                               color: Colors.grey
//                           )
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         )
//     );
//   }
//
// }


class RegistrationScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegistrationScreen> {
  String _email, _password, _displayName;
  final auth = FirebaseAuth.instance;
  Users user = new Users();
  AuthService _authService = new AuthService();

  // void initState() {
  //   AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
  //   _authService.initializeCurrentUser(authNotifier);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    //AuthNotifier authNotifier = Provider.of<AuthNotifier>(context, listen: false);
    return Scaffold(
      appBar: AppBar(title: Text('SignUp'),),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'UserName'
              ),
              onChanged: (value) {
                setState(() {
                  //user.displayName = value.trim();
                  _displayName = value.trim();
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Email'
              ),
              onChanged: (value) {
                setState(() {
                  //user.email = value.trim();
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
                  //user.password = value.trim();
                  _password = value.trim();
                });
              },
            ),

          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  hintText: 'Confirm Password'
              ),
              onChanged: (value) {
                setState(() {
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
                  child: Text('Signup'),
                  onPressed: (){
                    // _authService.signup(_email, _password, _displayName).then((curUser){
                    //   Users currentUser = curUser;
                    //   Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VerifyScreen(currentUser)));
                    // });
                    auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VerifyScreen(_displayName)));
                    });
                  },
                ),
                RaisedButton(
                    color: Theme.of(context).accentColor,
                    child: Text('Signin'),
                    onPressed: (){
                      //auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginScreen()));
                      }

                    )
              ])
        ],),
    );
  }
}