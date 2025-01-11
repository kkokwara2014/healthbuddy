import 'package:flutter/material.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/models/vital_sign_model.dart';

class VitalSignWidget extends StatelessWidget {
  const VitalSignWidget({
    super.key,
    required this.vsign,
  });

  final VitalSignModel vsign;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(
        right: 12,
      ),
      decoration: BoxDecoration(
          border: Border.all(
            color: pkColor,
          ),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Image.asset(
            vsign.image,
            width: 70,
            height: 70,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            vsign.name,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          Text(
            vsign.description,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black45,
            ),
          ),
        ],
      ),
    );
  }
}
