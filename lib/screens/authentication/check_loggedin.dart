import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/screens/admin/admin_landing_page.dart';
import 'package:health_buddy/screens/dashboard/landing_page.dart';
import 'package:health_buddy/screens/doctor/doc_landing_page.dart';
import 'package:health_buddy/screens/onborading.dart';
import 'package:health_buddy/widgets/loading_spinner.dart';

class CheckLoggedInUser extends StatefulWidget {
  const CheckLoggedInUser({super.key});

  @override
  State<CheckLoggedInUser> createState() => _CheckLoggedInUserState();
}

class _CheckLoggedInUserState extends State<CheckLoggedInUser> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return StreamBuilder<UserModel>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(snapshot.data!.uid)
                    .snapshots()
                    .map((user) => UserModel.fromFirestore(user)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final userData = snapshot.data;

                    if (userData?.role == "Admin") {
                      return const AdminLandingPage();
                    } else if (userData?.role == "Doctor") {
                      return const DocLandingPage();
                    } else if (userData?.role == "User") {
                      return const LandingPage();
                    } else {
                      // return const Onboarding();
                      return const LoadingSpinner(
                        text: "",
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Material(
                      child: Center(child: CircularProgressIndicator()),
                    );
                  } else {
                    // return const Onboarding();
                    return const LoadingSpinner(
                      text: "",
                    );
                  }
                });
          }

          return const Onboarding();
        });
  }
}
