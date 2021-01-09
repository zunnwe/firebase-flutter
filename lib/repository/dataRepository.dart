import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/models/parts.dart';
import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/models/reading-list.dart';
import 'package:comics_app/models/user.dart';
import 'package:comics_app/utils/userData_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';

class DataRepository{
  final CollectionReference collection = Firestore.instance.collection('pdfs');
  final CollectionReference readingList = Firestore.instance.collection('reading-list');
  var firebaseUser = FirebaseAuth.instance.currentUser;

  //List<UserData> _userData = [];

  //UnmodifiableListView<UserData> get userDataList => UnmodifiableListView(_userData);

  getusersData(UserDataNotifier notifier) async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('pdfs')
        .getDocuments();

    List<UserData> _userDataList = [];

    snapshot.documents.forEach((document) {
      UserData pdf = UserData.fromJson(document.data());
      _userDataList.add(pdf);
    });
    notifier.userDataList = _userDataList;
    print('userDtalist');
    print(_userDataList);
  }


  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
    // UserDataNotifier notifier = new UserDataNotifier();
    // return getusersData(notifier);
  }
  
  Future<DocumentReference> addPdf(UserData pdfs) {
    //_userData.add(pdfs);
    return collection.add(pdfs.toJson());
  }

  updatePdf(UserData pdfs) async {
    // String id;
    // var doc = await collection.getDocuments();
    // doc.documents.forEach((element) {
    //   id = element.id;
    // });
      await collection.document(pdfs.reference.documentID).updateData(pdfs.toJson());

  }

  deletePdf(UserData pdfs) async{
    await collection.document(pdfs.reference.documentID).delete();

  }

  Stream<QuerySnapshot> getReadingList(){
    return readingList.snapshots();
  }

  Future<DocumentReference> addReadingList(ReadingList books){
    return readingList.add(books.toJson());
  }

  deletePart(int index, List parts){
    if(parts == null){

    }
    else{
      // print(parts);
      List<Parts> partList = List<Parts>();
      partList = parts;
      partList.removeAt(index);
      //partList = parts;
      // print("partList");
      // print(partList);
      return partList;
    }
  }

  // updatePart(UserData userData, List<Parts> parts) async{
  //   await collection.document(userData.reference.documentID).update({'parts': parts});
  //
  // }

  // getPart() {
  //   List<Parts> parts;
  //     String part_id;
  //     final ref = Firestore.instance.collection('pdfs').doc('id').get().then((value) =>
  //     {
  //       parts = Pdfs.fromSnapshot(value).parts,
  //       parts.forEach((element) {
  //         part_id = element.part_id;
  //       })
  //     }
  //     );
  //     return part_id;
  //   }
  //     final ref = Firestore.instance.collection('pdfs').doc().get().then((value) => {
  //       parts = Pdfs.fromSnapshot(value).parts
  //     });
  //     return parts;
  // }
}