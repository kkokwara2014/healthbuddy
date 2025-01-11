import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/models/appointment_model.dart';

class AppointmentProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;

  addAppointment(
    String reason,
    String userid,
    String username,
    String useremail,
    String userphone,
    String userimage,
    String docid,
    String docname,
    String docemail,
    String docphone,
    String docimage,
    String apptdate,
  ) async {
    final newAppointment = AppointmentModel(
        reason: reason,
        userid: userid,
        username: username,
        useremail: useremail,
        userphone: userphone,
        userimage: userimage,
        docid: docid,
        docname: docname,
        docemail: docemail,
        docphone: docphone,
        docimage: docimage,
        apptdate: apptdate,
        ishandled: false,
        iscancelled: false,
        created: DateTime.now().toString());
    await _firestore.collection("appointments").add(newAppointment.toMap());
    notifyListeners();
  }

  Future<void> deleteAppointment(String apptId) async {
    await _firestore.collection("appointments").doc(apptId).delete();
    notifyListeners();
  }
}
