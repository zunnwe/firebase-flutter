import 'package:comics_app/repository/dataRepository.dart';
import 'package:comics_app/utils/userData_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:comics_app/models/user.dart';
import 'package:comics_app/repository/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:comics_app/screen/pdfListScreen.dart';
import 'package:comics_app/screen/searchStory.dart';
import 'package:comics_app/screen/readingList.dart';
import 'package:comics_app/screen/createStory.dart';
import 'package:comics_app/screen/editStory.dart';
import 'package:comics_app/screen/profilepage.dart';

class HomeScreen extends StatefulWidget{

  String displayName;
  HomeScreen(this.displayName);
  @override
  _HomeScreenState createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin{

  AuthService _authService = new AuthService();
  UserData pdfs;
  DataRepository repo;
  Users user;
  UserDataNotifier userDataNotifier;
  String displayName;
  File urlImageApi;
  TabController controller;
  int _currentIndex = 0;
  @override
  void initState() {
    displayName = widget.displayName;
    // TODO: implement initState
    super.initState();
    //controller = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    user = Provider.of<Users>(context);
    repo = new DataRepository(uid: user.id);
    //user.displayName = FirebaseAuth.instance.currentUser.displayName;
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Story App",
        ),
        actions: <Widget> [
              Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () => _authService.signOut(),
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> ProfileView())
                      );
                    },
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.black,
                      size: 50.0,
                    )
                  ),
                ],
              )
          //   },
          // )
          // action button
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int index) {
          setState(() {
            this._currentIndex = index;
          }
          );
          navigateScreen(index);
        }, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30, color: Colors.blue,),
            title: Text(''),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.search, size: 30, color: Colors.blue,),
            title: Text(''),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.local_library, size: 30, color: Colors.blue,),
              title: Text('')
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.create, size: 30, color: Colors.blue,),
              title: Text('')
          ),
        ],
      ),
      body: PdfListScreen()
    );
  }

  Widget navigateScreen(int index){
    if(index == 1){
      Navigator.push(context,
      MaterialPageRoute(builder: (context)=> SearchStoryScreen())
      );
    }
    if(index == 2){
      Navigator.push(context,
          MaterialPageRoute(builder: (context)=> ReadingListScreen())
      );
    }
    if(index == 3){
      showModalBottomSheet(
          context: context,
          builder: (BuildContext bc){
            return Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.post_add),
                      title: new Text('Create a new story'),
                      onTap: () => {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context)=> CreateStoryScreen())
                        )
                      }
                  ),
                  new ListTile(
                    leading: new Icon(Icons.edit_outlined),
                    title: new Text('Edit another story'),
                    onTap: () => {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> EditStoryScreen())
                      )
                    },
                  ),
                ],
              ),
            );
          }
      );
    }
  }
}



