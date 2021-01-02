import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference pdfCollection = Firestore.instance.collection('pdfs');

  Future<void> updateUserData(String pdf_path, File files) async {
    return await pdfCollection.document(uid).setData({
      'pdf_url': files,
      'pdf_path': pdf_path
    });
  }

  Future<void> insertData(File pdf_file, String pdf_path) async {
    final mainReference = FirebaseDatabase.instance.reference().child('Database');
    CollectionReference users = FirebaseFirestore.instance.collection('pdfs');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser.uid.toString();
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("mypdf" + DateTime.now().toString());
    UploadTask uploadTask = ref.putFile(pdf_file);
    String url = await (await uploadTask).ref.getDownloadURL();

    users.add({'pdf_url': url, 'pdf_path': pdf_path, 'uid': uid});
    return;
  }

  // brew list from snapshot
  List<Pdfs> _pdfListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc){
      //print(doc.data);
      return Pdfs(
          pdf_url: doc.data()['pdf_url'] ?? '',
          pdf_path: doc.data()['pdf_path']?? ''
      );
    }).toList();
  }

  // user data from snapshots
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        uid: uid,
        pdf_url: snapshot.data()['pdf_url'],
        pdf_path: snapshot.data()['pdf_path']
    );
  }

  // get brews stream
  Stream<List<Pdfs>> get pdfs {
    return pdfCollection.snapshots()
        .map(_pdfListFromSnapshot);
  }

  // get user doc stream
  Stream<UserData> get userData {
    return pdfCollection.document(uid).snapshots()
        .map(_userDataFromSnapshot);
  }

  // Future getPdfList() async {
  //   List itemsList = [];
  //   try {
  //     await pdfCollection.getDocuments().then((querySnapshot) {
  //       querySnapshot.documents.forEach((element) {
  //         itemsList.add(element.data);
  //       });
  //     });
  //     return itemsList;
  //   } catch (e) {
  //     print(e.toString());
  //     return null;
  //   }
  // }

}