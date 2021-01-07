import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Parts {
  String part_id;
  String name;
  String pdf_url;
  //File pdf_file;
  Timestamp createdAt;
  Timestamp updatedAt;
  DocumentReference reference;

  Parts(this.part_id, {this.name, this.pdf_url, this.reference, this.createdAt, this.updatedAt});


  factory Parts.fromJson(Map<dynamic, dynamic> json) => _PartFromJson(json);

  Map<String, dynamic> toJson() => _PartToJson(this);

  @override
  String toString() => "Part<$name>";

}

Parts _PartFromJson(Map<dynamic, dynamic> json) {
  return Parts(
    json['part_id'] as String,
    name: json['name'] as String,
    pdf_url: json['pdf_url'] as String,
    createdAt: json['created_at'] as Timestamp,
    updatedAt: json['updated_at'] as Timestamp
  );
}

Map<String, dynamic> _PartToJson(Parts instance) =>
    <String, dynamic> {
      'part_id': instance.part_id,
      'name': instance.name,
      'pdf_url': instance.pdf_url,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt
    };
