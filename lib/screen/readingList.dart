import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ReadingListScreen extends StatefulWidget{

  @override
  _ReadingListState createState() => _ReadingListState();
}

class _ReadingListState extends State<ReadingListScreen> {
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
      body: StreamBuilder(
          stream: getReadingListSnapshots(context),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text("Loading...");
            return new ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (BuildContext context, int index) =>
                    buildTripCard(context, snapshot.data.documents[index]));
          }
      ),

    );
  }

  Stream<QuerySnapshot> getReadingListSnapshots(BuildContext context) async* {
    final uid = FirebaseAuth.instance.currentUser.uid;
    yield* FirebaseFirestore.instance.collection('userData')
        .doc(uid)
        .collection('readingList')
        .snapshots();
  }

  Widget buildTripCard(BuildContext context, DocumentSnapshot pdfs) {
    return new Container(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 8.0, bottom: 4.0),
                child: Row(children: <Widget>[
                  Expanded(child: Text(pdfs['fiction_name'],
                    style: new TextStyle(fontSize: 30.0),
                  ),),
                  Expanded(child: ClipOval(
                    child: CachedNetworkImage(imageUrl: pdfs['image'],
                      width: 50.0,
                      height: 50.0,
                    ),
                  ))
                ]),
              ),

            ],
          ),
        ),
      ),
    );
  }
}