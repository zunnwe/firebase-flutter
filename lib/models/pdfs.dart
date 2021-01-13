
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
  int vote_count;
  bool completed;
  List<String> genre=[];
  String description;
  DocumentReference reference;

  Pdfs(this.id, {this.fiction_name, this.image, this.createdAt, this.updatedAt, this.reference, this.parts, this.username, this.view_count, this.vote_count, this.profile_pic, this.genre, this.completed, this.description});

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
    parts: _convertParts(json['parts'] as List),
    username: json['username'] as String,
    profile_pic: json['profile_pic'] as String,
    view_count: json['view_count'] as int,
    vote_count: json['vote_count'] as int,
    genre: json['genre'] as List,
    completed: json['completed'] as bool,
    description: json['descripton'] as String
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
      'updated_at': instance.updatedAt,
      'username': instance.username,
      'profile_pic': instance.profile_pic,
      'view_count': instance.view_count,
      'vote_count': instance.vote_count,
      'genre': instance.genre,
      'completed': instance.completed,
      'description': instance.description
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


