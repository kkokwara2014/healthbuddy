import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/screens/dashboard/appointments/book_appointment_screen.dart';
import 'package:health_buddy/screens/dashboard/visit_doctor/visit_doctor_screen.dart';

class DoctorListTileWidget extends StatelessWidget {
  const DoctorListTileWidget({
    super.key,
    required this.doctor,
  });

  final UserModel doctor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Get.to(
          () => BookAppointmentScreen(
            doctor: doctor,
          ),
        );
      },
      onLongPress: () {
        Get.to(() => VisitDoctorScreen(
              doctor: doctor,
            ));
      },
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image.network(
          doctor.userimage,
          width: 45,
          height: 45,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        doctor.name,
        style: const TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 18,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(doctor.phone),
          const SizedBox(
            height: 3,
          ),
          const Text(
            "Tap to book appointment",
            style: TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
      trailing: const Icon(
        Icons.arrow_circle_right_outlined,
        color: pkColor,
      ),
    );
  }
}
