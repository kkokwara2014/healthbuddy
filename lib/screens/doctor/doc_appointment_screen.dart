import 'package:flutter/material.dart';

class DocAppointmentScreen extends StatefulWidget {
  const DocAppointmentScreen({super.key});

  @override
  State<DocAppointmentScreen> createState() => _DocAppointmentScreenState();
}

class _DocAppointmentScreenState extends State<DocAppointmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Appointment Screen"),
      ),
    );
  }
}
