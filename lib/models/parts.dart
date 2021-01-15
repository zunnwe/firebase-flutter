import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

class Parts {
  String part_id;
  String name;
  String story;
  bool publish;
  String part_image_url;
  //File pdf_file;
  Timestamp createdAt;
  Timestamp updatedAt;
  DocumentReference reference;

  Parts(this.part_id, {this.name, this.story, this.reference, this.createdAt, this.updatedAt, this.publish, this.part_image_url});


  factory Parts.fromJson(Map<dynamic, dynamic> json) => _PartFromJson(json);

  Map<String, dynamic> toJson() => _PartToJson(this);

  @override
  String toString() => "Part<$name>";

}

Parts _PartFromJson(Map<dynamic, dynamic> json) {
  return Parts(
    json['part_id'] as String,
    name: json['name'] as String,
    story: json['pdf_url'] as String,
    publish: json['publish'] as bool,
    createdAt: json['created_at'] as Timestamp,
    updatedAt: json['updated_at'] as Timestamp,
    part_image_url: json['part_image_url'] as String
  );
}

Map<String, dynamic> _PartToJson(Parts instance) =>
    <String, dynamic> {
      'part_id': instance.part_id,
      'name': instance.name,
      'pdf_url': instance.story,
      'publish': instance.publish,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'part_image_url': instance.part_image_url
    };
