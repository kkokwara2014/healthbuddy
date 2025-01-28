import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/providers/appointment_provider.dart';
import 'package:health_buddy/providers/user_provider.dart';
import 'package:health_buddy/widgets/button_widget.dart';
import 'package:health_buddy/widgets/text_input.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointmentScreen extends StatefulWidget {
  const BookAppointmentScreen({super.key, required this.doctor});
  final UserModel doctor;

  @override
  State<BookAppointmentScreen> createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
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
  final _reasonController = TextEditingController();
  final _apptdateController = TextEditingController();

//for the form key
  final _formKey = GlobalKey<FormState>();

  //getting selected date from Table Calender
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    UserModel? userdata = Provider.of<UserProvider>(context).getuser;
    final apptProvider = Provider.of<AppointmentProvider>(context);

    if (userdata != null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Book Appointment"),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                // RichText(
                //   text: TextSpan(children: [
                //     const TextSpan(
                //         text: "Book Appointment with ",
                //         style: TextStyle(
                //           color: blackColor,
                //         )),
                //     TextSpan(
                //       text: widget.doctor.name,
                //       style: const TextStyle(
                //           fontWeight: FontWeight.w500,
                //           fontSize: 16,
                //           color: blackColor),
                //     ),
                //   ]),
                // ),
                const SizedBox(
                  height: 12,
                ),
                const Text("Fill and submit the form to book an appointment."),
                const SizedBox(
                  height: 7,
                ),
                Form(
                  key: _formKey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "You selected ${today.toString().split(" ")[0]}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      TableCalendar(
                        locale: "en_US",
                        focusedDay: today,
                        firstDay: DateTime.utc(2025, 01, 01),
                        lastDay: DateTime.utc(2030, 01, 01),
                        rowHeight: 43,
                        availableGestures: AvailableGestures.all,
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                        onDaySelected: _onDaySelected,
                        selectedDayPredicate: (day) => isSameDay(day, today),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      // TextFormField(
                      //   controller: _apptdateController,
                      //   decoration: const InputDecoration(
                      //     hintText: "Appointment Date",
                      //     border: OutlineInputBorder(),
                      //     prefixIcon: Icon(Icons.calendar_month),
                      //     contentPadding: EdgeInsets.all(17),
                      //   ),
                      //   readOnly: true,
                      //   validator: (value) {
                      //     if (value!.isEmpty) {
                      //       return "Appointment date required";
                      //     } else {
                      //       return null;
                      //     }
                      //   },
                      //   onTap: () {
                      //     _selectDate();
                      //   },
                      // ),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      MyTextInput(
                        controller: _reasonController,
                        hintText: "Appointment reason",
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
                              await apptProvider.addAppointment(
                                _reasonController.text.trim(),
                                userdata.uid!,
                                userdata.name,
                                userdata.email,
                                userdata.phone,
                                userdata.userimage,
                                widget.doctor.uid!,
                                widget.doctor.name,
                                widget.doctor.email,
                                widget.doctor.phone,
                                widget.doctor.userimage,
                                // _apptdateController.text.trim(),
                                today.toString().split(" ")[0],
                              );
                              Get.rawSnackbar(
                                  message: "Appointment booked successfully!");
                              Navigator.pop(context);
                            }
                          },
                          text: "Save Appointment")
                    ],
                  ),
                ),
              ],
            ),
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
        _apptdateController.text = _pickedDate.toString().split(" ")[0];
      });
    }
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      today = selectedDay;
    });
  }
}
