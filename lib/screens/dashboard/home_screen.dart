import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/constants/images.dart';
import 'package:health_buddy/models/user_model.dart';
import 'package:health_buddy/models/vital_sign_model.dart';
import 'package:health_buddy/screens/dashboard/doctors_list_screen.dart';
import 'package:health_buddy/screens/dashboard/vsign_category/bloodpressure_screen.dart';
import 'package:health_buddy/screens/dashboard/vsign_category/bmi_screen.dart';
import 'package:health_buddy/screens/dashboard/vsign_category/body_temperature_screen.dart';
import 'package:health_buddy/screens/dashboard/vsign_category/heart_rate_screen.dart';
import 'package:health_buddy/screens/dashboard/vsign_category/respiratory_rate_screen.dart';
import 'package:health_buddy/screens/dashboard/vsign_category/vital_sign_category.dart';
import 'package:health_buddy/widgets/doctor_list_tile_widget.dart';
import 'package:health_buddy/widgets/vital_sign_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<VitalSignModel> _vitalSigns = vitalSigns;

  //get all doctors
  Query get allDoctors => FirebaseFirestore.instance
      .collection("users")
      .where("role", isEqualTo: "Doctor")
      .orderBy("name", descending: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            headerBanner(),
            const SizedBox(height: 8),
            categoryAndAll(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  children: List.generate(
                _vitalSigns.length,
                (index) {
                  final vSign = _vitalSigns[index];
                  return GestureDetector(
                    onTap: () {
                      if (vSign.storedname == "bloodpressures") {
                        Get.to(
                            () => BloodPressureScreen(vitalSignModel: vSign));
                      } else if (vSign.storedname == "heartrates") {
                        Get.to(() => HeartRateScreen(vitalSignModel: vSign));
                      } else if (vSign.storedname == "respiratoryrates") {
                        Get.to(
                            () => RespiratoryRateScreen(vitalSignModel: vSign));
                      } else if (vSign.storedname == "bodytemperatures") {
                        Get.to(
                            () => BodyTemperatureScreen(vitalSignModel: vSign));
                      } else if (vSign.storedname == "bmis") {
                        Get.to(() => BMIScreen(vitalSignModel: vSign));
                      }
                    },
                    child: VitalSignWidget(vsign: vSign),
                  );
                },
              )),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Doctors List",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      Get.to(() => const DoctorsListScreen());
                    },
                    child: Text(
                      "View All",
                      style: TextStyle(fontSize: 13, color: pkColor.shade300),
                    ))
              ],
            ),
            Expanded(
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
          ],
        ),
      ),
    );
  }

  Container headerBanner() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: pkColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              medicalbannerImage,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 100,
            left: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: blackColor.withOpacity(0.6),
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(12),
                      topRight: Radius.circular(12))),
              height: 60,
              width: 265,
            ),
          ),
          const Positioned(
              top: 105,
              left: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Manage your health!",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: whiteColor),
                  ),
                  Text(
                    "Your health is important to us.",
                    style: TextStyle(fontSize: 15, color: whiteColor),
                  ),
                ],
              ))
        ],
      ),
    );
  }

  Row categoryAndAll() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Category",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        TextButton(
          onPressed: () {
            Get.to(() => const VitalSignCategory());
          },
          child: Text(
            "View All",
            style: TextStyle(
              fontSize: 13,
              color: pkColor.shade300,
            ),
          ),
        ),
      ],
    );
  }
}
