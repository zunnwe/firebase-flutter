import 'package:flutter/material.dart';

class EditStoryScreen extends StatefulWidget{

  _editStoryScreenState createState() => _editStoryScreenState();
}

class _editStoryScreenState extends State<EditStoryScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Create"),
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
