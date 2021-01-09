
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'parts.dart';

class Pdfs {
  String fiction_name;
  String id;
  String image;
 // String pdf_path;
  List<Parts> parts = List<Parts>();
  Timestamp createdAt;
  Timestamp updatedAt;
  String profile_pic;
  String username;
  int view_count;
  int rating;
  bool completed;
  List<String> genre=[];
  DocumentReference reference;

  Pdfs(this.id, {this.fiction_name, this.image, this.createdAt, this.updatedAt, this.reference, this.parts});

  factory Pdfs.fromSnapshot(DocumentSnapshot snapshot) {
    Pdfs newPdf = Pdfs.fromJson(snapshot.data());
    newPdf.reference = snapshot.reference;
    return newPdf;
  }

  factory Pdfs.fromJson(Map<String, dynamic> json) => _PdfFromJson(json);

  Map<String, dynamic> toJson() => _PdfToJson(this);

  @override
  String toString() => "Pdf<$id>";
}

Pdfs _PdfFromJson(Map<String, dynamic> json) {
  return Pdfs(
    json['id'] as String,
    fiction_name: json['fiction_name'] as String,
    image: json['image'] as String,
    //pdf_path: json['pdf_path'] as String,
    createdAt: json['created_at'] as Timestamp,
    updatedAt: json['updated_at'] as Timestamp,
    parts: _convertParts(json['parts'] as List)
  );
}

List<Parts> _convertParts(List partMap) {
  if (partMap == null) {
    return null;
  }
  List<Parts> parts =  List<Parts>();
  partMap.forEach((value) {
    parts.add(Parts.fromJson(value));
  });
  return parts;
}

var uuid = Uuid();
Map<String, dynamic> _PdfToJson(Pdfs instance) => <String, dynamic> {
      'id': instance.id,
      'fiction_name': instance.fiction_name,
      'image': instance.image,
      //'pdf_path': instance.pdf_path,
      'parts': _PartList(instance.parts),
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt
    };

List<Map<String, dynamic>> _PartList(List<Parts> parts) {
  if (parts == null) {
    return null;
  }
  List<Map<String, dynamic>> partMap =List<Map<String, dynamic>>();
  parts.forEach((part) {
    partMap.add(part.toJson());
  });
  return partMap;
}


