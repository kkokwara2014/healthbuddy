import 'package:flutter/material.dart';
import 'package:health_buddy/models/vital_sign_model.dart';

class RespiratoryRateScreen extends StatefulWidget {
  const RespiratoryRateScreen({super.key, required this.vitalSignModel});
  final VitalSignModel vitalSignModel;

  @override
  State<RespiratoryRateScreen> createState() => _RespiratoryRateScreenState();
}

class _RespiratoryRateScreenState extends State<RespiratoryRateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vitalSignModel.name),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Text(widget.vitalSignModel.name),
        ),
      ),
    );
  }
}
