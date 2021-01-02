import 'package:comics_app/models/user.dart';
import 'package:comics_app/screens/discover.dart';
import 'package:comics_app/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Users>(context);
    
    // return either the Home or Authenticate widget
    if (user == null){
      return LoginScreen();
    } else {
      return DiscoverScreen();
    }
    
  }
}