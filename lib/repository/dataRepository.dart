import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:comics_app/models/parts.dart';
import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/models/reading-list.dart';
import 'package:comics_app/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DataRepository {
  final CollectionReference collection = Firestore.instance.collection('pdfs');
  final CollectionReference readingList = Firestore.instance.collection('reading-list');

  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }
  
  Future<DocumentReference> addPdf(UserData pdfs) {
    return collection.add(pdfs.toJson());
  }

  updatePdf(UserData pdfs) async {
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

  List<Parts> _deletePart(int index, List parts){
    if(parts == null){
      return null;
    }

    List<Parts> partList = List<Parts>();
    parts.forEach((element) {
      partList.remove(index);
    });
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