import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/widgets/doctor_list_tile_widget.dart';

class DoctorsListScreen extends StatefulWidget {
  const DoctorsListScreen({super.key});

  @override
  State<DoctorsListScreen> createState() => _DoctorsListScreenState();
}

class _DoctorsListScreenState extends State<DoctorsListScreen> {
  //get all doctors
  Query get allDoctors => FirebaseFirestore.instance
      .collection("users")
      .where("role", isEqualTo: "Doctor")
      .orderBy("name", descending: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Doctors"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: StreamBuilder(
            stream: allDoctors.snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                if (snapshot.hasData) {
                  final doctors = snapshot.data!.docs
                      .map((e) => UserModel.fromFirestore(e))
                      .toList();
                  return ListView.separated(
                      itemCount: doctors.length,
                      separatorBuilder: (context, index) => const Divider(
                            thickness: 1,
                          ),
                      itemBuilder: (context, index) {
                        final doctor = doctors[index];
                        return DoctorListTileWidget(doctor: doctor);
                      });
                } else {
                  return const Center(
                    child: Text("No Doctor available."),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
