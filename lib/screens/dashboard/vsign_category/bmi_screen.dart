import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/models/bmi_model.dart';
import 'package:health_buddy/models/vital_sign_model.dart';
import 'package:health_buddy/providers/bmi_provider.dart';
import 'package:health_buddy/screens/dashboard/vsign_category/add_bmi.dart';
import 'package:provider/provider.dart';

class BMIScreen extends StatefulWidget {
  const BMIScreen({super.key, required this.vitalSignModel});
  final VitalSignModel vitalSignModel;

  @override
  State<BMIScreen> createState() => _BMIScreenState();
}

class _BMIScreenState extends State<BMIScreen> {
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  //get all doctors
  Query get allBmis => FirebaseFirestore.instance
      .collection("bmis")
      .where("uid", isEqualTo: _userId)
      .orderBy("created", descending: false);
  @override
  Widget build(BuildContext context) {
    final bmiProvider = Provider.of<BMIProvider>(context);
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
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(bmi.report),
                                      Text(bmi.created),
                                    ],
                                  ),
                                  trailing: IconButton(
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title:
                                                      const Text("Delete BMI?"),
                                                  content: const Text(
                                                      "Do you want to delete this record?"),
                                                  actions: [
                                                    MaterialButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text("No")),
                                                    MaterialButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                          bmiProvider.deleteBMI(
                                                              bmi.id!);
                                                        },
                                                        child:
                                                            const Text("Yes")),
                                                  ],
                                                ));
                                      },
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: redColor,
                                      )),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton.small(
        onPressed: () {
          Get.to(() => const AddBMIScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
