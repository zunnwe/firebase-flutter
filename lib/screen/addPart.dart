import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:comics_app/models/user.dart';
import 'package:comics_app/repository/dataRepository.dart';
import 'package:provider/provider.dart';
import 'package:comics_app/models/parts.dart';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddPartScreen extends StatefulWidget{

  String title;
  String description;
  String imageUrl;
  // final UserData pdfs;
  String uid;
  //final docId;
  AddPartScreen(this.title, this.description, this.imageUrl, this.uid);
  @override
  _AddPartScreenState createState() => _AddPartScreenState();
}

enum Choices { save, delete}

class _AddPartScreenState extends State<AddPartScreen>{

  bool publish;
  String title2;
  String story;
  String dropdownValue="save";
  File _image;
  String imageUrl2;
  String title;
  String description;
  String imageUrl;
  Choices _selectedChoices = Choices.save;
  UserData pdfs;
  DataRepository repository;
  Parts newPart;
  var uuid = new Uuid();
  var docId;

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEditingController2 = TextEditingController();
  String uid;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    title = widget.title;
    description = widget.description;
    imageUrl = widget.imageUrl;
    // pdfs = widget.pdfs;
    uid = widget.uid;
    // docId = widget.docId;
    print('title');
    print(title);
    print('description');
    print(description);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Users>(context);
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
      FirebaseStorage storage = FirebaseStorage.instance;
      Reference ref = storage.ref().child("partImg" + DateTime.now().toString());
      UploadTask uploadTask = ref.putFile(_image);
      imageUrl2 = await (await uploadTask).ref.getDownloadURL();
    }
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
        title: Text("Add Part"),
        leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        }
        ),
        actions: <Widget>[
          FlatButton(
            onPressed: (){

            },
            child: Text("PUBLISH"),
          ),
          PopupMenuButton<Choices> (
            elevation: 3.2,
            onSelected: (Choices result) {
              setState((){
                _selectedChoices = result;
                if(_selectedChoices == Choices.save){
                  pdfs = UserData(uid , fiction_name: title,id: uuid.v1(), image: imageUrl, description: description, createdAt: Timestamp.now(), updatedAt: Timestamp.now() );
                  Parts newParts = Parts(uuid.v1(), name: title2, pdf_url: story, part_image_url: imageUrl2, createdAt: Timestamp.now(), updatedAt: Timestamp.now());
                  if (pdfs.parts == null) {
                    pdfs.parts = List<Parts>();
                  }
                  pdfs.parts.add(newParts);

                  Firestore.instance.collection("userData").document(uid).collection("pdfs").add(pdfs.toJson());
                  savetoServer(uid, title, title2, description, imageUrl, imageUrl2, story, pdfs);
                }
                if(_selectedChoices == Choices.delete){
                  repository.deletePdf(pdfs);
                }
              });
              },
            onCanceled: () {
              print('You chose nothing');
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
              const PopupMenuItem<Choices>(
                value: Choices.save,
                child: Text("Save")
              ),
              const PopupMenuItem<Choices>(
                value: Choices.delete,
                child: Text("Delete")
              ),
            ],

          )
        ],
    ),
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    getImage();
                  },
                  child: Container(
                    width: 300,
                    height: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Colors.grey,
                          width: 2,
                        )
                    ),
                    child: Text("Tap to add media"),
                  ),
                ),

              ],
            ),
            SizedBox(
              width: 200.0,
              height: 30.0,
            ),

            _buildTitleField(),

            _buildStoryField(),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _textEditingController,
      decoration: InputDecoration(labelText: 'Title your Story Part'),
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
        title2 = value;
       // newPart.name = value;
      },
    );
  }

  Widget _buildStoryField() {
    return TextFormField(
      controller: _textEditingController2,
      decoration: InputDecoration(labelText: 'Tap here to start writing'),
      keyboardType: TextInputType.text,
      style: TextStyle(fontSize: 20),
      validator: (String value) {
        if (value.isEmpty) {
          return 'title is required';
        }

        if (value.length < 3 || value.length > 20) {
          return 'Story must be more than 50 and less than 500';
        }

        return null;
      },
      onChanged: (String value) {
        story = value;
        //newPart.pdf_url = value;
      },
    );
  }

  savetoServer(String uid, String title, String title2, String description, String imageUrl, String imageUrl2, String story, UserData pdfs) async{
    pdfs = UserData(uid , fiction_name: title,id: uuid.v1(), image: imageUrl, description: description, createdAt: Timestamp.now(), updatedAt: Timestamp.now() );
    Parts newParts = Parts(uuid.v1(), name: title2, pdf_url: story, part_image_url: imageUrl2, createdAt: Timestamp.now(), updatedAt: Timestamp.now());
    if (pdfs.parts == null) {
      pdfs.parts = List<Parts>();
    }
    pdfs.parts.add(newParts);

    DataRepository().addPdf(pdfs);
  }

}



