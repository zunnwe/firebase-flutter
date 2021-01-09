import 'package:comics_app/repository/auth.dart';
import 'package:comics_app/screen/verify.dart';
import 'package:flutter/material.dart';
import 'package:comics_app/utils/constants.dart';
import 'package:comics_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:comics_app/screen/pdfListScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
//
// class LoginScreen extends StatelessWidget{
//
//   final AuthService _authService = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   String error = "";
//   @override
//   Widget build(BuildContext context) {
//     String mail;
//     String password;
//     // TODO: implement build
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           // Container(
//           //   child: Stack(
//           //     children: [
//           //       Container(
//           //         padding: EdgeInsets.fromLTRB(0.0, 110.0, 0.0, 0.0),
//           //         child: Text(
//           //           'Hello',
//           //           style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.lightBlue)
//           //         ),
//           //       ),
//           //       Container(
//           //         padding: EdgeInsets.fromLTRB(30.0, 180.0, 0.0, 0.0),
//           //         child: Text(
//           //           'There.',
//           //           style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.lightBlue),
//           //         ),
//           //       )
//           //     ],
//           //   ),
//           // ),
//
//           Column(
//             children: [
//               Form(
//                 key: _formKey,
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                           padding: EdgeInsets.fromLTRB(10.0, 50.0, 10.0, 10.0),
//                           child: TextFormField(
//                             validator: (val)=> val.isEmpty? "Enter your email": null,
//                             style: TextStyle(color: Colors.black87),
//                               decoration: buildEmailField,
//                               onChanged: (val){
//                               mail = val;
//                               },
//                           ),
//                           ),
//                         Container(
//                           padding: EdgeInsets.all(10.0),
//                           child: TextFormField(
//                             validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
//                             style: TextStyle(color: Colors.black87),
//                             decoration: buildPasswordField,
//                             onChanged: (val){
//                               password = val;
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//               ),
//
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: <Widget>[
//                   Container(
//                     padding: EdgeInsets.fromLTRB(40.0, 80.0, 0.0, 0.0),
//                     child: ButtonTheme(
//                       minWidth: 300.0,
//                       height: 30.0,
//                       child: RaisedButton(
//                         color: Colors.lightBlue,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0)
//                         ),
//                         child: Text(
//                             'Login',
//                             style: TextStyle(
//                                 color: Colors.white
//                             )
//                         ),
//                         onPressed: () async{
//                           if(_formKey.currentState.validate()){
//                             dynamic result = await _authService.signInWithEmailAndPassword(mail, password);
//                             if(result == null) {
//                               error = "Could not sign in with those credentials";
//                             }
//                           }
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => PdfListScreen()),
//                           );
//                         },
//                       ),
//                     ),
//                   ),
//                   Container(
//                     padding: EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
//                     child: ButtonTheme(
//                       minWidth: 300.0,
//                       height: 30.0,
//                       child: RaisedButton(
//                         color: Colors.white,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0)
//                         ),
//                         onPressed: (){
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => PdfListScreen()),
//                           );
//                         },
//                         child: Text(
//                             'Create New Account',
//                             style: buttonTextStyle
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           )],
//       )
//       );
//   }
// }

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password;
  final auth = FirebaseAuth.instance;

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
                      auth.signInWithEmailAndPassword(email: _email, password: _password).then((_){
                        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => PdfListScreen()));
                      });

                    }),
                RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Signup'),
                  onPressed: (){
                    auth.createUserWithEmailAndPassword(email: _email, password: _password).then((_){
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => VerifyScreen()));
                    });

                  },
                ),
              ])
        ],),
    );
  }
}