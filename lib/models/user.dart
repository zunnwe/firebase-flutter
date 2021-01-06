import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'parts.dart';
import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/models/parts.dart';
import 'package:uuid/uuid.dart';

class Users {

  final String uid;

  Users({ this.uid });
}

class UserData {

  final String uid;
  String fiction_name;
  String id;
  String image;
  // String pdf_path;
  List<Parts> parts = List<Parts>();
  Timestamp createdAt;
  Timestamp updatedAt;
  DocumentReference reference;

  UserData(this.uid, { this.fiction_name, this.id, this.image, this.parts, this.createdAt, this.updatedAt, this.reference});

  factory UserData.fromSnapshot(DocumentSnapshot snapshot) {
    UserData newUserData = UserData.fromJson(snapshot.data());
    newUserData.reference = snapshot.reference;
    return newUserData;
  }

  factory UserData.fromJson(Map<String, dynamic> json) => _UserDataFromJson(json);

  Map<String, dynamic> toJson() => _UserDataToJson(this);

  @override
  String toString() => "UserData<$uid>";
}

UserData _UserDataFromJson(Map<String, dynamic> json) {
  return UserData(
      json['uid'] as String,
      fiction_name: json['fiction_name'] as String,
      id: json['id'] as String,
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
Map<String, dynamic> _UserDataToJson(UserData instance) => <String, dynamic> {
  'uid': instance.uid == null? null : uuid.v1(),
  'id': instance.id == null ? null : uuid.v4(),
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


