import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/models/parts.dart';
import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/models/reading-list.dart';
import 'package:comics_app/models/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'dart:collection';
import 'package:firebase_auth/firebase_auth.dart';

class DataRepository with ChangeNotifier{
  final CollectionReference collection = Firestore.instance.collection('pdfs');
  final CollectionReference readingList = Firestore.instance.collection('reading-list');
  var firebaseUser = FirebaseAuth.instance.currentUser;

  List<UserData> _userData = [];

  UnmodifiableListView<UserData> get userDataList => UnmodifiableListView(_userData);

  set userDataList(List<UserData> userDataList) {
    _userData = userDataList;
    notifyListeners();
  }

  get userData async{
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('pdfs')
        .get();

    List<UserData> _userDataList = [];

    snapshot.documents.forEach((document) {
      UserData pdf = UserData.fromJson(document.data());
      _userDataList.add(pdf);
    });
    userDataList = _userDataList;
  }

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  
  Future<DocumentReference> addPdf(UserData pdfs) {
    _userData.add(pdfs);
    return collection.add(pdfs.toJson());
  }

  updatePdf(UserData pdfs) async {
      await collection.document(pdfs.reference.documentID).updateData(pdfs.toJson());
      notifyListeners();
  }

  deletePdf(UserData pdfs) async{
    _userData.clear();
    await collection.document(pdfs.reference.documentID).delete();
    notifyListeners();
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
      print(parts);
      List<Parts> partList = List<Parts>();
      parts.forEach((element) {
        partList.remove(index);
        _userData.remove(index);
      });
      print(partList);
      return partList;
    }
  }

  updatePart(UserData userData, List<Parts> parts) async{
    await collection.document(userData.reference.documentID).update({'parts': parts});
    notifyListeners();

  }

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