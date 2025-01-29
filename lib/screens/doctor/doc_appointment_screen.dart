import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/models/appointment_model.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/providers/appointment_provider.dart';
import 'package:health_buddy/providers/user_provider.dart';
import 'package:provider/provider.dart';

class DocAppointmentScreen extends StatefulWidget {
  const DocAppointmentScreen({super.key});

  @override
  State<DocAppointmentScreen> createState() => _DocAppointmentScreenState();
}

class _DocAppointmentScreenState extends State<DocAppointmentScreen> {
  @override
  void initState() {
    updateData();
    super.initState();
  }

  updateData() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    await userProvider.refreshUser();
  }

  final docCommentController = TextEditingController();
  bool toggleCommentWidget = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    docCommentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserModel? userdata = Provider.of<UserProvider>(context).getuser;
    final appointmentProvider = Provider.of<AppointmentProvider>(context);

    if (userdata != null) {
      return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("appointments")
                .where("docemail", isEqualTo: userdata.email)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text("No available appointment for you!"),
                );
              }
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final appointments = snapshot.data!.docs
                          .map((e) => AppointmentModel.fromFirestore(e))
                          .toList();
                      final appointment = appointments[index];
                      return Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: Image.network(
                                    appointment.userimage,
                                    fit: BoxFit.cover,
                                    height: 40,
                                    width: 40,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(appointment.username),
                              ],
                            ),
                            Text(appointment.reason),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(appointment.created
                                    .toString()
                                    .split(" ")[0]),
                                !appointment.ishandled
                                    ? TextButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => Form(
                                              key: _formKey,
                                              autovalidateMode: AutovalidateMode
                                                  .onUserInteraction,
                                              child: AlertDialog(
                                                title: Text("Add Comment"),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                        "Comment on the appointment for\n"),
                                                    Text(appointment.reason,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        )),
                                                    TextFormField(
                                                      maxLines: 3,
                                                      controller:
                                                          docCommentController,
                                                      decoration: InputDecoration(
                                                          label: Text(
                                                              "Add comment here")),
                                                      validator: (val) {
                                                        if (val!.isEmpty) {
                                                          return "Comment required";
                                                        } else {
                                                          return null;
                                                        }
                                                      },
                                                    ),
                                                  ],
                                                ),
                                                actions: [
                                                  MaterialButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text("Cancel"),
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () async {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        await appointmentProvider
                                                            .handleAppointmentByDoctor(
                                                                appointment,
                                                                docCommentController
                                                                    .text
                                                                    .trim());
                                                        docCommentController
                                                            .clear();
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: Text("Submit"),
                                                  )
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text("Comment"),
                                      )
                                    : SizedBox.shrink(),
                              ],
                            ),
                            appointment.ishandled
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Divider(
                                        thickness: 1,
                                      ),
                                      Text("Doctor's Comment"),
                                      Text(
                                        appointment.doccomment!,
                                        style: TextStyle(
                                          fontStyle: FontStyle.italic,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  )
                                : SizedBox.shrink(),
                          ],
                        ),
                      );
                    });
              }
              return Container();
            }),
      );
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
