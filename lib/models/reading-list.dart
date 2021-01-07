
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';
import 'parts.dart';

class ReadingList {
  String rid;
  String fiction_name;
  String pid;
  String image;
  String uid;
  // String pdf_path;
  DocumentReference reference;

  ReadingList(this.rid, {this.fiction_name, this.image, this.pid, this.uid, this.reference});

  factory ReadingList.fromSnapshot(DocumentSnapshot snapshot) {
    ReadingList newlist = ReadingList.fromJson(snapshot.data());
    newlist.reference = snapshot.reference;
    return newlist;
  }

  factory ReadingList.fromJson(Map<String, dynamic> json) => _ReadingListFromJson(json);

  Map<String, dynamic> toJson() => _ReadingListToJson(this);

  @override
  String toString() => "Pdf<$rid>";
}

ReadingList _ReadingListFromJson(Map<String, dynamic> json) {
  return ReadingList(
      json['rid'] as String,
      fiction_name: json['fiction_name'] as String,
      image: json['image'] as String,
      uid: json['uid'] as String,
      pid: json['pid'] as String
      //pdf_path: json['pdf_path'] as String,
  );
}

var uuid = Uuid();
Map<String, dynamic> _ReadingListToJson(ReadingList instance) => <String, dynamic> {
  'rid': instance.rid == null ? null : uuid.v1(),
  'fiction_name': instance.fiction_name,
  'image': instance.image,
  'uid': instance.uid,
  'pid': instance.pid
  //'pdf_path': instance.pdf_path,

};




