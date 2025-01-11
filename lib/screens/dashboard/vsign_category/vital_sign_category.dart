import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/models/vital_sign_model.dart';
import 'package:health_buddy/screens/dashboard/vital_sign_detail.dart';

class VitalSignCategory extends StatefulWidget {
  const VitalSignCategory({super.key});

  @override
  State<VitalSignCategory> createState() => _VitalSignCategoryState();
}

class _VitalSignCategoryState extends State<VitalSignCategory> {
  List<VitalSignModel> vSigns = vitalSigns;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Categories"),
      ),
      body: ListView.separated(
          itemCount: vSigns.length,
          separatorBuilder: (context, index) => const Divider(
                thickness: 1,
              ),
          itemBuilder: (context, index) {
            final vs = vSigns[index];
            return ListTile(
              onTap: () {
                Get.to(() => VitalSignDetailScreen(vitalSignModel: vs));
              },
              leading: Image.asset(
                vs.image,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(
                vs.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              subtitle: Text(vs.description),
              trailing: const Icon(
                Icons.arrow_circle_right_outlined,
                color: pkColor,
              ),
            );
          }),
    );
  }
}
