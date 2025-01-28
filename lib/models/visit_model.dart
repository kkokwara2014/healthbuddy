// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:health_buddy/models/user_model.dart';

class VisitModel {
  final String? id;
  final String uid;
  final String date;
  final String purpose;
  final UserModel doctor;

  VisitModel(
      {this.id,
      required this.uid,
      required this.date,
      required this.purpose,
      required this.doctor});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'date': date,
      'purpose': purpose,
      'doctor': doctor.toMap(),
    };
  }

  factory VisitModel.fromMap(Map<String, dynamic> map) {
    return VisitModel(
      id: map['id'] != null ? map['id'] as String : null,
      uid: map['uid'] as String,
      date: map['date'] as String,
      purpose: map['purpose'] as String,
      doctor: UserModel.fromMap(map['doctor'] as Map<String, dynamic>),
    );
  }
  factory VisitModel.fromFirestore(DocumentSnapshot map) {
    return VisitModel(
      id: map.id,
      uid: map['uid'] as String,
      date: map['date'] as String,
      purpose: map['purpose'] as String,
      doctor: UserModel.fromMap(map['doctor'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory VisitModel.fromJson(String source) =>
      VisitModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
