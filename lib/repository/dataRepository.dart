import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/models/parts.dart';
import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/models/reading-list.dart';
import 'package:comics_app/models/user.dart';
import 'package:comics_app/utils/userData_notifier.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DataRepository{
  final CollectionReference collection = Firestore.instance.collection('pdfs');
  final CollectionReference readingList = Firestore.instance.collection('reading-list');
  var firebaseUser = FirebaseAuth.instance.currentUser;
  final String uid;
  DataRepository({this.uid});

  //List<UserData> _userData = [];

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

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
    print('userdataliast');
    print(_userDataList);
  }

  
  Future<DocumentReference> addPdf(UserData pdfs) async{
    //_userData.add(pdfs);
    return collection.add(pdfs.toJson());
  }


  updatePdf(UserData pdfs) async {

    Future<QuerySnapshot> books =
    Firestore.instance
        .collection("pdfs").where("id", isEqualTo: pdfs.id).getDocuments();
    books.then((value) {
      value.documents.forEach((element) {
        Firestore.instance
            .collection("pdfs")
            .document(element.documentID)
            .delete()
            .then((value) => print("success"));
      });

    });
  }

  updatePdfByUser(UserData pdfs) async {

    Future<QuerySnapshot> books =
    Firestore.instance
        .collection("userData")
        .document(uid)
        .collection("pdfs").where("id", isEqualTo: pdfs.id).getDocuments();
    books.then((value) {
      value.documents.forEach((element) {
        Firestore.instance
            .collection("userData")
            .document(uid)
            .collection("pdfs")
            .document(element.documentID)
            .delete()
            .then((value) => print("success"));
      });

    });
  }

  deletePdf(UserData pdfs) async{
    Future<QuerySnapshot> books =
    Firestore.instance
        .collection("pdfs").where("id", isEqualTo: pdfs.id).getDocuments();
    books.then((value) {
      value.documents.forEach((element) {
        Firestore.instance
            .collection("pdfs")
            .document(element.documentID)
            .delete()
            .then((value) => print("success"));
      });
    });
  }

  deletePart(int index, List parts){
    if(parts == null){

    }
    else{
      // print(parts);
      List<Parts> partList = List<Parts>();
      partList = parts;
      partList.removeAt(index);
      return partList;
    }
  }




}