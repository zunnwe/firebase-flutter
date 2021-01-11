import 'package:flutter/material.dart';

class ReadingListScreen extends StatefulWidget{

  @override
  _ReadingListState createState() => _ReadingListState();
}

class _ReadingListState extends State<ReadingListScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Library"),
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