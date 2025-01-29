import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/models/appointment_model.dart';
import 'package:health_buddy/providers/appointment_provider.dart';
import 'package:provider/provider.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  //getting user appointments
  Query get userAppointments => FirebaseFirestore.instance
      .collection("appointments")
      .where("userid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy("created", descending: true);

  @override
  Widget build(BuildContext context) {
    final apptProvider = Provider.of<AppointmentProvider>(context);
    return Scaffold(
      body: StreamBuilder(
          stream: userAppointments.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                final appointments = snapshot.data!.docs
                    .map((e) => AppointmentModel.fromFirestore(e))
                    .toList();
                return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemBuilder: (context, index) {
                      final appointment = appointments[index];
                      return GestureDetector(
                        onTap: () {},
                        onLongPress: () {
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                    title: const Text("Delete Appointment?"),
                                    content: const Text(
                                        "Do you want to delete appointment?"),
                                    actions: [
                                      MaterialButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("No"),
                                      ),
                                      MaterialButton(
                                        onPressed: () async {
                                          await apptProvider.deleteAppointment(
                                              appointment.id!);
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Yes"),
                                      ),
                                    ],
                                  ));
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          margin: const EdgeInsets.only(top: 8, bottom: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: pkColor),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                appointment.reason,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                appointment.apptdate,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "To see: ${appointment.docname}",
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Transform(
                                    transform: Matrix4.identity()..scale(0.8),
                                    child: Chip(
                                        backgroundColor: !appointment.ishandled
                                            ? redColor
                                            : pkColor,
                                        label: Text(
                                          !appointment.ishandled
                                              ? "Not seen"
                                              : "Handled",
                                          style: const TextStyle(
                                              color: whiteColor),
                                        )),
                                  )
                                ],
                              ),
                              // const SizedBox(height: 5,),
                              appointment.ishandled
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text("Doctor's comment"),
                                        Text(
                                          appointment.doccomment!,
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      );
                    },
                    itemCount: appointments.length);
              } else {
                return const Center(
                    child: Text(
                  "No appointment records yet!",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ));
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
