import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:comics_app/models/user.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:comics_app/repository/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';


class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  Users users;
  String bio;
  String displayName;
  File _image;
  String imageUrl;
  var snapshots;
  User firebaseuser;
  TextEditingController _userbioController = TextEditingController();
  TextEditingController _userDisplayNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    users = Provider.of<Users>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        actions: [
          FlatButton(
            onPressed: (){
              _userEditBottomSheet(context);
            },
            child: Text("edit"),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            FutureBuilder(
              future: AuthService().getCurrentUser(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return displayUserInformation(context, snapshot);
                } else {
                  return CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Widget displayUserInformation(context, snapshot) {
    final authData = snapshot.data;
    return Column(
      children: <Widget>[
        StreamBuilder(
            stream: _getProfileData(context),
            builder: (context, snapshot) {
              if(!snapshot.hasData) return const Text("Loading...");
              return SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                ListView.builder(
                shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, int index) =>
                        buildListCard(context, snapshot.data.documents[index]))
                  ],
                )
              );
            }
        ),
        //showSignOut(context, authData.isAnonymous),
      ],
    );
  }

  Stream<QuerySnapshot> _getProfileData(BuildContext context) async* {
    // final uid = await Provider.of(context).auth.getCurrentUID();
    var uid = FirebaseAuth.instance.currentUser.uid;
    yield* FirebaseFirestore.instance.collection('userData').doc(uid).collection('data').snapshots();
  }

  Widget buildListCard(BuildContext context, DocumentSnapshot pdfs) {
    return Container(
      margin: EdgeInsets.all(10.0),
      width: 350,
      height: 530,
      child: Card(
        child: Column(
          children: <Widget>[
              CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.white,
                child: Image.network(
                  (pdfs['photoUrl'] == null)? 'https://www.materialui.co/materialIcons/image/add_a_photo_black_36x36.png'
                      : pdfs['photoUrl'],
                  fit: BoxFit.fill,
                ),
              ),
            FlatButton(
              color: Colors.blue,
              onPressed: () async{
                imageUrl = await getImage();
                users.photoUrl = imageUrl;
                var uid = await FirebaseAuth.instance.currentUser.uid;
                await Firestore.instance
                    .collection("userData")
                    .document(uid)
                    .collection('data')
                    .where("bio", isEqualTo: users.bio)
                    .getDocuments()
                    .then((res) {
                  res.documents.forEach((result) {
                    Firestore.instance
                        .collection("userData")
                        .document(uid)
                        .collection("data")
                        .document(result.documentID)
                        .updateData({"photoUrl": imageUrl});
                  });
                });
              },
              child:Text("change profile")
            ),
            Text(
              "Name: ${ pdfs['displayName']}",
              style: TextStyle(fontSize: 20),
            ),
            Text(
              "Bio: ${ pdfs['bio']}",
              style: TextStyle(fontSize: 20),
            ),
          ],
        )
      ),
    );
  }

  Widget showSignOut(context, bool isAnonymous) {
    if (isAnonymous == true) {
      return RaisedButton(
        child: Text("Sign In To Save Your Data"),
        onPressed: () {
          Navigator.of(context).pushNamed('/convertUser');
        },
      );
    } else {
      return RaisedButton(
        child: Text("Sign Out"),
        onPressed: () async {
          try {
            await AuthService().signOut();
          } catch (e) {
            print(e);
          }
        },
      );
    }
  }

  void _userEditBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext bc) {
        return Container(
          height: MediaQuery.of(context).size.height * .60,
          child: Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 15.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text("Update Profile"),
                    Spacer(),
                    IconButton(
                      icon: Icon(Icons.cancel),
                      color: Colors.orange,
                      iconSize: 25,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextField(
                          controller: _userbioController,
                          decoration: InputDecoration(
                            helperText: "Bio",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15.0),
                        child: TextField(
                          controller: _userDisplayNameController,
                          decoration: InputDecoration(
                            helperText: "UserName",
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text('Save'),
                      color: Colors.green,
                      textColor: Colors.white,
                      onPressed: () async {
                        users.bio = _userbioController.text;
                        users.displayName = _userDisplayNameController.text;
                        users.photoUrl = imageUrl;
                        setState(() {
                          _userbioController.text = users.bio;
                          _userDisplayNameController.text = users.displayName;
                          imageUrl = users.photoUrl;
                        });
                        final uid = await AuthService().getCurrentUID();
                        // await FirebaseFirestore.instance.collection("userData").document(uid).collection("data").add(users.toJson());
                        Firestore.instance
                            .collection("userData")
                            .document(uid)
                            .collection('data')
                            .where("photoUrl", isEqualTo: users.photoUrl)
                            .getDocuments()
                            .then((res) {
                          res.documents.forEach((result) {
                            Firestore.instance
                                .collection("userData")
                                .document(uid)
                                .collection("data")
                                .document(result.documentID)
                                .updateData({"displayName": users.displayName, "bio": users.bio});
                          });
                        });
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
      print('Image Path $_image');
    });
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("partImg" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(_image);
    imageUrl = await (await uploadTask).ref.getDownloadURL();
    return imageUrl;
  }
}
