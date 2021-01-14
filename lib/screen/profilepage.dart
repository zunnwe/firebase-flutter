import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comics_app/repository/auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class ProfileView extends StatelessWidget {

  File _image;
  String imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Edit Profile")),
      body: Container(
        width: MediaQuery
            .of(context)
            .size
            .width,
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
    var user = snapshot.data;
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);
        _image = image;
        print('Image Path $_image');

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("partImg" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(_image);
      imageUrl = await (await uploadTask).ref.getDownloadURL();
      user.photoUrl = imageUrl;
    }

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
              onTap: () async{
                getImage();
                await user.reload();
                user = AuthService().getCurrentUser();
              },
              child: ClipOval(
                child: CachedNetworkImage(imageUrl: user.photoUrl?? "https://www.materialui.co/materialIcons/image/add_a_photo_black_36x36.png",
                  width: 80.0,
                  height: 80.0,
                ),
              )
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Name: ${user.displayName ?? 'Anonymous'}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Email: ${user.email ?? 'Anonymous'}", style: TextStyle(fontSize: 20),),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Created: ${DateFormat('MM/dd/yyyy').format(
              user.metadata.creationTime)}", style: TextStyle(fontSize: 20),),
        ),
      ],
    );
  }

}