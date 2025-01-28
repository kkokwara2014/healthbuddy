import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/models/visit_model.dart';
import 'package:health_buddy/providers/user_provider.dart';
import 'package:health_buddy/widgets/button_widget.dart';
import 'package:health_buddy/widgets/text_input.dart';
import 'package:provider/provider.dart';

class VisitDoctorScreen extends StatefulWidget {
  const VisitDoctorScreen({super.key, required this.doctor});
  final UserModel doctor;

  @override
  State<VisitDoctorScreen> createState() => _VisitDoctorScreenState();
}

class _VisitDoctorScreenState extends State<VisitDoctorScreen> {
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

  //for getting appointment inputs
  final _purposeController = TextEditingController();
  final _dateController = TextEditingController();

//for the form key
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UserModel? userdata = Provider.of<UserProvider>(context).getuser;

    if (userdata != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Book Visit"),
        ),
        body: Container(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.network(
                        widget.doctor.userimage,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    Text(
                      widget.doctor.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.doctor.phone,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const Text("Fill and submit the form to visit a Doctor."),
              const SizedBox(
                height: 7,
              ),
              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _dateController,
                      decoration: const InputDecoration(
                        hintText: "Visiting Date",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.calendar_month),
                        contentPadding: EdgeInsets.all(17),
                      ),
                      readOnly: true,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Visiting date required";
                        } else {
                          return null;
                        }
                      },
                      onTap: () {
                        _selectDate();
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    MyTextInput(
                      controller: _purposeController,
                      hintText: "Visit reason",
                      prefixicon: Icons.access_alarm_outlined,
                      hideText: false,
                      textInputType: TextInputType.text,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    MyButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            //adding visit to firebase
                            final newVisit = VisitModel(
                                uid: userdata.uid!,
                                date: _dateController.text,
                                purpose: _purposeController.text.trim(),
                                doctor: widget.doctor);
                            await FirebaseFirestore.instance
                                .collection("visits")
                                .add(newVisit.toMap());

                            Get.rawSnackbar(
                                message: "Visit booked successfully!");
                            Navigator.pop(context);
                          }
                        },
                        text: "Save")
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }

  Future<void> _selectDate() async {
    DateTime? _pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (_pickedDate != null) {
      setState(() {
        _dateController.text = _pickedDate.toString().split(" ")[0];
      });
    }
  }
}
