import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/models/bmi_model.dart';
import 'package:health_buddy/models/vital_sign_model.dart';

class BloodPressureScreen extends StatefulWidget {
  const BloodPressureScreen({super.key, required this.vitalSignModel});
  final VitalSignModel vitalSignModel;

  @override
  State<BloodPressureScreen> createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  //get all doctors
  Query get allBmis => FirebaseFirestore.instance
      .collection("bloodpressures")
      .where("uid", isEqualTo: _userId)
      .orderBy("created", descending: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vitalSignModel.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder(
                    stream: allBmis.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.active) {
                        if (snapshot.hasData) {
                          final bmis = snapshot.data!.docs
                              .map((e) => BmiModel.fromFirestore(e))
                              .toList();
                          return ListView.separated(
                              itemCount: bmis.length,
                              separatorBuilder: (context, index) =>
                                  const Divider(
                                    thickness: 1,
                                  ),
                              itemBuilder: (context, index) {
                                final bmi = bmis[index];
                                return ListTile(
                                  title: Text(bmi.height.toString()),
                                );
                              });
                        } else {
                          return const Center(
                            child: Text("No BMI record for you."),
                          );
                        }
                      } else {
                        return const Center(child: CircularProgressIndicator());
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
