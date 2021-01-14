import 'package:flutter/material.dart';
import 'package:comics_app/models/user.dart';
import 'package:comics_app/repository/dataRepository.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:comics_app/models/reading-list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewStoryInfo extends StatefulWidget{

  UserData pdf;
  final uid;
  ViewStoryInfo(this.uid, this.pdf);
  @override
  _ViewStoryInfoState createState() => _ViewStoryInfoState();
}

class _ViewStoryInfoState extends State<ViewStoryInfo>{
  UserData pdf;
  String uid;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pdf = widget.pdf;
    uid = widget.uid;
  }

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(pdf.fiction_name== null ? "" : pdf.fiction_name),
          leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              }),
        ),
        body: PdfDetailForm(uid, pdf),
      ),
    );
  }
}

class PdfDetailForm extends StatefulWidget {
  final UserData pdfs;
  final uid;

  const PdfDetailForm(this.uid, this.pdfs);

  @override
  _PdfDetailFormState createState() => _PdfDetailFormState();
}

class _PdfDetailFormState extends State<PdfDetailForm> {
  final DataRepository repository = DataRepository();
  String story_name;
  String image;
  String pdf_path;
  String pdf_url;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(5.0),
      child: Column(
        children: <Widget>[
          Expanded(
                child: CachedNetworkImage(imageUrl: widget.pdfs.image,
                  width: 350.0,
                  height: 100.0,
                  imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                    colorFilter:
                    ColorFilter.mode(Colors.white, BlendMode.colorBurn)),
                  ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
          Expanded(
              child: Column(
                children: <Widget>[
                  Text(widget.pdfs.fiction_name == null ? "" : widget.pdfs.fiction_name, style: TextStyle(fontSize: 20)),
                  FlatButton(
                    color: Colors.lightBlueAccent,
                    onPressed: (){
                      String userId = FirebaseAuth.instance.currentUser.uid;
                      ReadingList readingList = ReadingList(widget.uid , fiction_name: widget.pdfs.fiction_name, image: widget.pdfs.image );

                      Firestore.instance.collection("userData").document(userId).collection("readingList").add(readingList.toJson());
                    },
                    child: Text("Add to Library"),
                  )
                ],
              )),
          Text(widget.pdfs.description == null ? "" : widget.pdfs.description, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }


}