import 'package:flutter/material.dart';
import 'package:comics_app/screen/home.dart';
import 'package:comics_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:comics_app/repository/dataRepository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:comics_app/main.dart';

class SearchStoryScreen extends StatefulWidget{

  @override
  _SearchStoryState createState() => _SearchStoryState();
}

class _SearchStoryState extends State<SearchStoryScreen>{
  // DataRepository repo;
  Users user;
  @override
  Widget build(BuildContext context) {
    user = Provider.of<Users>(context);
    // repo = new DataRepository(uid: user.uid);
    //user.displayName = FirebaseAuth.instance.currentUser.displayName;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Story"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
          }
        ),
      ),
    );
  }

}