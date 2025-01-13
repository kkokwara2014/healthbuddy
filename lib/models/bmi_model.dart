// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class BmiModel {
  final String? id;
  final String uid;
  final String height;
  final String weight;
  final String report;
  final String created;

  BmiModel(
      {this.id,
      required this.uid,
      required this.height,
      required this.weight,
      required this.report,
      required this.created});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'height': height,
      'weight': weight,
      'report': report,
      'created': created,
    };
  }

  factory BmiModel.fromMap(Map<String, dynamic> map) {
    return BmiModel(
      id: map['id'] != null ? map['id'] as String : null,
      uid: map['uid'] as String,
      height: map['height'] as String,
      weight: map['weight'] as String,
      report: map['report'] as String,
      created: map['created'] as String,
    );
  }
  factory BmiModel.fromFirestore(DocumentSnapshot map) {
    return BmiModel(
      id: map.id,
      uid: map['uid'] as String,
      height: map['height'] as String,
      weight: map['weight'] as String,
      report: map['report'] as String,
      created: map['created'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory BmiModel.fromJson(String source) =>
      BmiModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
