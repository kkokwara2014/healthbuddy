import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/constants/images.dart';
import 'package:health_buddy/models/user_model.dart';

class AuthUserProvider extends ChangeNotifier {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  User? get currentUser => _auth.currentUser;
  bool get isSignedIn => currentUser != null;

  Future<void> signIn(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
    notifyListeners();
  }

  Future<void> signUp(String name, String email, String phone, String password,
      String rolename) async {
    UserCredential uc = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    //create an instance of the user
    final newUser = UserModel(
        uid: uc.user!.uid,
        name: name,
        email: email,
        phone: phone,
        password: password,
        role: rolename,
        userimage: userImage);
    await _firestore.collection("users").doc(uc.user!.uid).set(newUser.toMap());
    notifyListeners();
  }

  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}
