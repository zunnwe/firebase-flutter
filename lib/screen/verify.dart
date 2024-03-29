import 'dart:async';

import 'package:comics_app/screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:comics_app/utils/auth_notifier.dart';
import 'package:comics_app/models/user.dart';
import 'dart:io';

class VerifyScreen extends StatefulWidget {

  String _displayName;
  //File _imageFile;
  VerifyScreen(this._displayName);
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  final auth = FirebaseAuth.instance;
  User user;
  Timer timer;
  String _displayName;

  @override
  void initState() {
    user = auth.currentUser;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      checkEmailVerified();
    });
    _displayName = widget._displayName;
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
            'An email has been sent to ${user.email} please verify'),
      ),
    );
  }

  //AuthNotifier authNotifier = new AuthNotifier();
  Future<void> checkEmailVerified() async {
    user = auth.currentUser;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      //authNotifier.setUser(currentUser);
      //print(currentUser.displayName);
      user.updateProfile(
          displayName: _displayName);
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen(_displayName)));
    }
  }

  // Future UpdatePic(File imageFile) async{
  //
  //   FirebaseStorage storage = FirebaseStorage.instance;
  //   Reference ref = storage.ref().child("profile_pic" + DateTime.now().toString());
  //   UploadTask uploadTask = ref.putFile(_imageFile);
  //   photoUrl = await (await uploadTask).ref.getDownloadURL();
  //   print('photourl:');
  //   print(photoUrl);
  // }
}