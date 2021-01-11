import 'package:flutter/material.dart';

class CreateStoryScreen extends StatefulWidget{

  _createStoryScreenState createState() => _createStoryScreenState();
}

class _createStoryScreenState extends State<CreateStoryScreen>{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Story"),
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
