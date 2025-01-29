// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentModel {
  final String? id;
  final String reason;
  final String userid;
  final String username;
  final String useremail;
  final String userphone;
  final String userimage;
  final String docid;
  final String docname;
  final String docemail;
  final String docphone;
  final String docimage;
  final String? doccomment;
  final String apptdate;
  final bool ishandled;
  final bool iscancelled;
  final String created;

  AppointmentModel(
      {this.id,
      required this.reason,
      required this.userid,
      required this.username,
      required this.useremail,
      required this.userphone,
      required this.userimage,
      required this.docid,
      required this.docname,
      required this.docemail,
      required this.docphone,
      required this.docimage,
      this.doccomment,
      required this.apptdate,
      required this.ishandled,
      required this.iscancelled,
      required this.created});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reason': reason,
      'userid': userid,
      'username': username,
      'useremail': useremail,
      'userphone': userphone,
      'userimage': userimage,
      'docid': docid,
      'docname': docname,
      'docemail': docemail,
      'docphone': docphone,
      'docimage': docimage,
      'doccomment': doccomment,
      'apptdate': apptdate,
      'ishandled': ishandled,
      'iscancelled': iscancelled,
      'created': created,
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] != null ? map['id'] as String : null,
      reason: map['reason'] as String,
      userid: map['userid'] as String,
      username: map['username'] as String,
      useremail: map['useremail'] as String,
      userphone: map['userphone'] as String,
      userimage: map['userimage'] as String,
      docid: map['docid'] as String,
      docname: map['docname'] as String,
      docemail: map['docemail'] as String,
      docphone: map['docphone'] as String,
      docimage: map['docimage'] as String,
      doccomment: map['doccomment'] as String,
      apptdate: map['apptdate'] as String,
      ishandled: map['ishandled'] as bool,
      iscancelled: map['iscancelled'] as bool,
      created: map['created'] as String,
    );
  }
  factory AppointmentModel.fromFirestore(DocumentSnapshot map) {
    return AppointmentModel(
      id: map.id,
      reason: map['reason'] as String,
      userid: map['userid'] as String,
      username: map['username'] as String,
      useremail: map['useremail'] as String,
      userphone: map['userphone'] as String,
      userimage: map['userimage'] as String,
      docid: map['docid'] as String,
      docname: map['docname'] as String,
      docemail: map['docemail'] as String,
      docphone: map['docphone'] as String,
      docimage: map['docimage'] as String,
      doccomment: map['doccomment'] as String,
      apptdate: map['apptdate'] as String,
      ishandled: map['ishandled'] as bool,
      iscancelled: map['iscancelled'] as bool,
      created: map['created'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory AppointmentModel.fromJson(String source) =>
      AppointmentModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
