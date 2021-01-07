import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PartListScreen extends StatefulWidget{

  @required String part;
  PartListScreen(this.part);
  @override
  _PartListState createState()=> _PartListState();
}

class _PartListState extends State<PartListScreen>{
  String part_name;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    part_name = widget.part;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(

        child: Text(part_name, style: TextStyle(fontSize: 30)),

    );
  }


}

