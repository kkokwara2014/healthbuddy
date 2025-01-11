import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/services/auth_methods.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  final AuthMethods _authMethods = AuthMethods();
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  final _firestore = FirebaseFirestore.instance;

  UserModel? get getuser => _user;

  Future<void> refreshUser() async {
    UserModel user = await _authMethods.getUser();
    _user = user;
    notifyListeners();
  }

  Future<void> changeName(String name) async {
    if (name.isNotEmpty) {
      await _firestore.collection("users").doc(_userId).update({
        "name": name,
      });
    }
    notifyListeners();
  }

  Future<void> changePhone(String phone) async {
    if (phone.isNotEmpty) {
      await _firestore.collection("users").doc(_userId).update({
        "phone": phone,
      });
    }
    notifyListeners();
  }
}
