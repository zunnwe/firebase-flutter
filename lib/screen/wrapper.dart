import 'package:comics_app/screen/pdfListScreen.dart';
import 'package:comics_app/models/user.dart';
import 'package:comics_app/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:comics_app/screen/registration.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return LoginScreen();
    } else {
      return PdfListScreen();
    }
    
  }
}