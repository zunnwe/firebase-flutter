import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comics_app/repository/dataRepository.dart';
import 'package:comics_app/models/parts.dart';
import 'package:comics_app/models/user.dart';
import 'package:provider/provider.dart';
class PartListScreen extends StatefulWidget{

  @required String part_name;
  int index;
  List<Parts> parts;
  PartListScreen(this.part_name, this.index, this.parts);
  @override
  _PartListState createState()=> _PartListState();
}

class _PartListState extends State<PartListScreen>{
  String part_name;
  int index;
  List<Parts> part;
  var datarepo = DataRepository();
  List<Parts> partList = List<Parts>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    part_name = widget.part_name;
    index = widget.index;
    part = widget.parts;
  }

  @override
  Widget build(BuildContext context) {
    final  userDataList= Provider.of<DataRepository>(context, listen: false).userDataList;
    UserData pdfs;
    print("userDatalist");
    print(userDataList);
    userDataList.forEach((element) {
      pdfs = element;
    });
    print("pdfs:");
    print(pdfs);
    // TODO: implement build
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
          color: Colors.grey,
          width: 340.0,
          height: 48.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(part_name,
                style: TextStyle(fontSize: 20)
              ),
              RaisedButton(
                onPressed: (){
                  //print(part);
                  partList = datarepo.deletePart(index, part);
                  datarepo.updatePart(pdfs, partList);
                },
                child: Text('delete'),
              )
            ]
          ),

      ),

    );
  }


}

