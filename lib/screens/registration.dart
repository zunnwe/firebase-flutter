import 'package:comics_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:comics_app/utilities/constants.dart';

class RegistrationScreen extends StatelessWidget{
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = "";
  @override
  Widget build(BuildContext context) {
    String mail;
    String password;
    String username;
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Stack(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
                    child: Text(
                        'Hello',
                        style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.lightBlue)
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(30.0, 180.0, 0.0, 0.0),
                    child: Text(
                      'There.',
                      style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.lightBlue),
                    ),
                  )
                ],
              ),
            ),
            Column(
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? "Enter your username" : null,
                          style: TextStyle(color: Colors.black87),
                          decoration: buildUsernameField,
                          onChanged: (val){
                            username = val;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10.0, 10.0, 10.0, 10.0),
                        child: TextFormField(
                          validator: (val)=> val.isEmpty? "Enter your email": null,
                          style: TextStyle(color: Colors.black87),
                          decoration: buildEmailField,
                          onChanged: (val){
                            mail = val;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10.0),
                        child: TextFormField(
                          validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                          style: TextStyle(color: Colors.black87),
                          decoration: buildPasswordField,
                          onChanged: (val){
                            password = val;
                          },
                        ),
                      ),
                      SizedBox(height: 12.0),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14.0),
                      )
                    ],
                  ),
                ),
              ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(40.0, 30.0, 0.0, 0.0),
                  child: ButtonTheme(
                    minWidth: 300.0,
                    height: 30.0,
                    child: RaisedButton(
                      color: Colors.lightBlue,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      child: Text(
                          'Create New Account',
                          style: TextStyle(
                              color: Colors.white
                          )
                      ),
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          dynamic result = await _authService.registerWithEmailAndPassword(mail, password);
                          if(result == null){
                            error = 'Please supply a valid credentials';
                          }
                        }
                        Navigator.of(context).pushNamed('/discover');
                      },
                    ),
                  ),

                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40.0, 20.0, 0.0, 0.0),
                  child: ButtonTheme(
                    minWidth: 300.0,
                    height: 30.0,
                    child: RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                      ),
                      onPressed: (){
                        Navigator.of(context).pushNamed('/signIn');
                      },
                      child: Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.grey
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        )
    );
  }

}