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
import 'package:path_provider/path_provider.dart';

class HomeScreen extends StatefulWidget{

  // Users currentUser;
  // HomeScreen(this.currentUser);
  @override
  _HomeScreenState createState()=> _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{

  AuthService _authService = new AuthService();
  UserData pdfs;
  DataRepository repo;
  Users user;
  UserDataNotifier userDataNotifier;
  File urlImageApi;
  @override
  void initState() {
    //currentUser = widget.currentUser;
    // TODO: implement initState
    // user = Provider.of<Users>(context);
    // repo = new DataRepository(uid: user.uid);
    // user.displayName = FirebaseAuth.instance.currentUser.displayName;
    // userDataNotifier = Provider.of<UserDataNotifier>(context, listen: false);
    // repo.getusersData(userDataNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //AuthNotifier authNotifier = Provider.of<AuthNotifier>(context);
    user = Provider.of<Users>(context);
    repo = new DataRepository(uid: user.uid);
    user.displayName = FirebaseAuth.instance.currentUser.displayName;
    userDataNotifier = Provider.of<UserDataNotifier>(context, listen: false);
    repo.getusersData(userDataNotifier);
    // Future<void> _refreshList() async {
    //   pdfs = repo.getusersData(notifier);
    // }
   Future<void> userdata = repo.getusersData(userDataNotifier);
   print("userdata");
   print(userdata);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user != null? user.displayName: "Story App",
        ),
        actions: <Widget> [
          FutureBuilder<String>(
            future: userdata,
            builder: (context, AsyncSnapshot<dynamic> snapshot){
              pdfs = UserData.fromSnapshot(snapshot.data());
              createFileOfImageUrl(pdfs).then((result){
                setState(() {
                  urlImageApi = result;
                });
              });
              return Row(
                children: <Widget>[
                  FlatButton(
                    onPressed: () => _authService.signOut(),
                    child: Text(
                      "Logout",
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      radius: 100,
                      backgroundColor: Color(0xff476cfb),
                      child: ClipOval(
                        child: new SizedBox(
                          width: 20.0,
                          height: 20.0,
                          child: (pdfs.image!=null)?Image.file(
                            urlImageApi,
                            fit: BoxFit.fill,
                          ):Image.network(
                            "https://images.unsplash.com/photo-1502164980785-f8aa41d53611?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=500&q=60",
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          )
          // action button

        ],
      ),
    );
  }

  Future<File> createFileOfImageUrl(UserData pdfs) async {
    final url = pdfs.image;
    final filename = url.substring(url.lastIndexOf("/") + 1);
    var request = await HttpClient().getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = new File('$dir/$filename');
    await file.writeAsBytes(bytes);
    return file;
  }
}

