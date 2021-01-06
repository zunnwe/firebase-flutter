import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/models/user.dart';

class DataRepository {
  final CollectionReference collection = Firestore.instance.collection('pdfs');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  
  Future<DocumentReference> addPdf(UserData pdfs) {
    return collection.add(pdfs.toJson());
  }

  updatePdf(UserData pdfs) async {
      await collection.document(pdfs.reference.documentID).updateData(pdfs.toJson());
  }
}