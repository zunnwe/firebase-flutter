import 'package:comics_app/screen/pdfDetail.dart';
import 'package:comics_app/screen/pdfListScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:comics_app/repository/dataRepository.dart';
import 'package:comics_app/models/parts.dart';
import 'package:comics_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:comics_app/utils/userData_notifier.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartListScreen extends StatefulWidget{

  @required String part_name;
  @required int index;
  @required List<Parts> parts;
  @required UserData pdfs;
  PartListScreen(this.pdfs, this.part_name, this.index, this.parts);
  @override
  _PartListState createState()=> _PartListState();
}

class _PartListState extends State<PartListScreen>{
  String part_name;
  int index;
  List<Parts> part;
  UserData pdfs;
  //DataRepository repo = new DataRepository();
  List<Parts> partList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    part_name = widget.part_name;
    index = widget.index;
    part = widget.parts;
    pdfs = widget.pdfs;
  }

  @override
  Widget build(BuildContext context) {
    DataRepository repo = new DataRepository();
    UserDataNotifier notifier = Provider.of<UserDataNotifier>(context);
    //repo.getusersData(notifier);
    // var pdfs;
    //  _refreshList()  {
    //     repo.getusersData(notifier).toList();
    // }
    // print('pdfs');
    // print(pdfs);
    // print("userDatalist");
    // print(userDataList);
    // userDataList.forEach((element) {
    //   pdfs = element;
    // });
    // print("pdfs:");
    // print(repo.getusersData(notifier));
    // TODO: implement build
    return Scaffold(
      body: Container(
        //padding: const EdgeInsets.all(10.0),
          margin: const EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
          color: Colors.grey,
          width: 340.0,
          height: 48.0,
          child:Column(
            children: <Widget>[
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(part_name,
                        style: TextStyle(fontSize: 20)
                    ),
                    RaisedButton(
                      onPressed: () {
                        //print(part);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> PdfListScreen())
                        );
                        setState(() {
                          partList = repo.deletePart(index, part);
                          print("partList");
                          print(partList);
                          //part = partList;
                          repo.updatePdf(pdfs);
                          partList.forEach((element) {
                            print('part added');
                            pdfs.parts.add(element);
                            pdfs.parts.removeAt(index);
                            partList.remove(element);
                          });
                        });
                        //print("done");
                        //repo.updatePdf(pdfs);
                        // pdfs.parts.removeWhere((item) => item.part_id == part[index].part_id);
                        // print('pdfs');
                        // print(pdfs);
                        // datarepo.updatePart(pdfs, partList);
                      },
                      child: Text('delete'),
                    )
                  ]
              ),
              // new RefreshIndicator(
              //    child: ListView.builder(
              //         itemBuilder:  (BuildContext context, int index){
              //           partList = notifier.dataList[index].parts;
              //           notifier.dataList[index].parts.clear();
              //           partList.forEach((element) {
              //             notifier.dataList[index].parts.add(element);
              //           });
              //         },
              //         itemCount: notifier.dataList.length),
              //   onRefresh: _refreshList,
              // ),
            ],
          )
      ),

      // body: new RefreshIndicator(
      //   child: ListView.separated(
      //     itemBuilder: (BuildContext context, int index) {
      //       return Container(
      //             padding: const EdgeInsets.all(10.0),
      //               margin: const EdgeInsets.fromLTRB(10.0, 30.0, 0.0, 0.0),
      //               color: Colors.grey,
      //               width: 340.0,
      //               height: 48.0,
      //               child: Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: <Widget>[
      //                   Text(part_name,
      //                     style: TextStyle(fontSize: 20)
      //                   ),
      //                   RaisedButton(
      //                     onPressed: (){
      //                       //print(part);
      //                        partList = repo.deletePart(indexToDelete, part);
      //                        notifier.dataList[index].parts.clear();
      //                        partList.forEach((element) {
      //                          notifier.dataList[index].parts.add(element);
      //                        });
      //                       // pdfs.parts.clear();
      //                       // partList.forEach((element) {
      //                       //   pdfs.parts.add(element);
      //                       // });
      //                       // print('pdfs');
      //                       // print(pdfs);
      //                       repo.updatePdf(notifier.dataList[index]);
      //                       // datarepo.updatePart(pdfs, partList);
      //                     },
      //                     child: Text('delete'),
      //                   )
      //                 ]
      //               ));
      //     },
          // itemCount: notifier.dataList.length,
          // separatorBuilder: (BuildContext context, int index) {
          //   return Divider(
          //     color: Colors.black,
          //   );
          // },
    //     ),
    //     onRefresh: _refreshList,
    //   ),
    //
    );
  }


}

