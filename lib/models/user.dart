import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'parts.dart';
import 'package:comics_app/models/pdfs.dart';
import 'package:comics_app/models/parts.dart';
import 'package:uuid/uuid.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Users {
  final String id;
  final String username;
  final String email;
  final String photoUrl;
  final String displayName;
  final String bio;

  Users(this.id, {
    this.username,
    this.email,
    this.photoUrl,
    this.displayName,
    this.bio,
  });

  factory Users.fromDocument(DocumentSnapshot doc) {
    return Users(
      doc['id'] as String,
      email: doc['email'] as String,
      username: doc['username'] as String,
      photoUrl: doc['photoUrl'] as String,
      displayName: doc['displayName'] as String,
      bio: doc['bio'] as String,
    );
  }
}


class UserData {

  String uid;
  String fiction_name;
  String id;
  String image;
  // String pdf_path;
  List<Parts> parts = List<Parts>();
  Timestamp createdAt;
  Timestamp updatedAt;
  int view_count;
  int vote_count;
  bool completed;
  List<dynamic> genre= List<String>();
  String description;
  DocumentReference reference;

  UserData(this.uid, { this.fiction_name, this.id, this.image, this.parts, this.createdAt, this.updatedAt, this.reference, this.view_count, this.vote_count, this.completed, this.genre, this.description});


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
      view_count: json['view_count'] as int,
      vote_count: json['vote_count'] as int,
      completed: json['completed'] as bool,
      genre: json['genre'] as List,
      parts: _convertParts(json['parts'] as List),
      description: json['description'] as String
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
  'uid': instance.uid,
  'id': instance.id,
  'fiction_name': instance.fiction_name,
  'image': instance.image,
  //'pdf_path': instance.pdf_path,
  'parts': _PartList(instance.parts),
  'created_at': instance.createdAt,
  'view_count': instance.view_count,
  'vote_count': instance.vote_count,
  'completed': instance.completed,
  'genre': instance.genre,
  'updated_at': instance.updatedAt,
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

UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
  return UserData(
      snapshot.data()['uid'] as String,
      fiction_name: snapshot.data()['fiction_name'] as String,
      id: snapshot.data()['id'] as String,
      image: snapshot.data()['image'] as String,
      //pdf_path: json['pdf_path'] as String,
      createdAt: snapshot.data()['created_at'] as Timestamp,
      updatedAt: snapshot.data()['updated_at'] as Timestamp,
      view_count: snapshot.data()['view_count'] as int,
      vote_count: snapshot.data()['vote_count'] as int,
      completed: snapshot.data()['completed'] as bool,
      genre: snapshot.data()['genre'] as List,
      //parts: _convertParts(snapshot.data()['parts'] as List),
      description: snapshot.data()['description'] as String
  );
}

Stream<DocumentSnapshot> getuserDataList() async*{
  //CollectionReference userDataCollection = Firestore.instance.collection('pdfs');
  // yield* userDataCollection
  //     .doc(uid).snapshots().map(_userDataFromSnapshot);
  User user = await FirebaseAuth.instance.currentUser;
  yield* FirebaseFirestore.instance.collection('pdfs').doc(user.uid).snapshots();
}








