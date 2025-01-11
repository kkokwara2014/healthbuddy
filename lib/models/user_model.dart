// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String? uid;
  final String name;
  final String email;
  final String phone;
  final String password;
  final String role;
  final String userimage;

  UserModel({
    this.uid,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.role,
    required this.userimage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'role': role,
      'userimage': userimage,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] != null ? map['uid'] as String : null,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
      userimage: map['userimage'] as String,
    );
  }
  factory UserModel.fromFirestore(DocumentSnapshot map) {
    return UserModel(
      uid: map.id,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String,
      password: map['password'] as String,
      role: map['role'] as String,
      userimage: map['userimage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
