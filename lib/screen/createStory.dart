import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:comics_app/screen/addPart.dart';
import 'package:comics_app/models/user.dart';
import 'package:provider/provider.dart';

class CreateStoryScreen extends StatefulWidget{

  _createStoryScreenState createState() => _createStoryScreenState();
}

class _createStoryScreenState extends State<CreateStoryScreen>{

  File _image;
  String imageUrl;
  String title;
  String description;
  UserData pdfs;
  var docId;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final user = Provider.of<Users>(context);
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });

      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("storycover" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(_image);
      imageUrl = await (await uploadTask).ref.getDownloadURL();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Story Info"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }
        ),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.arrow_forward), onPressed: () {
            //UserData data = UserData(user.uid, fiction_name: title, description: description, image: imageUrl);
           // DataRepository().addPdf(data);
            Navigator.push(context,
            MaterialPageRoute( builder: (context)=> AddPartScreen(title, description, imageUrl, user.uid))
            );
          }),
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                     getImage();
                  },
                  child: Container(
                    width: 100,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.black87,
                          width: 2,
                        )
                    ),
                    child: Text("add a cover"),
                  ),
                ),

              ],
            ),

            _buildTitleField(),

            _buildDescriptionField(),

          ],
        ),
      )
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _textEditingController,
      decoration: InputDecoration(labelText: 'title'),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'title is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'title must be more than 5 and less than 50';
        }

        return null;
      },
      onChanged: (String value) {
        title = value;
        pdfs.fiction_name = value;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _textEditingController2,
      decoration: InputDecoration(labelText: 'description'),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'description is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'description must be more than 10 and less than 100';
        }

        return null;
      },
      onChanged: (String value) {
        description = value;
        pdfs.description = value;
      },
    );
  }

}
