import 'package:flutter/material.dart';
import 'package:health_buddy/models/vital_sign_model.dart';

class BodyTemperatureScreen extends StatefulWidget {
  const BodyTemperatureScreen({super.key, required this.vitalSignModel});
  final VitalSignModel vitalSignModel;

  @override
  State<BodyTemperatureScreen> createState() => _BodyTemperatureScreenState();
}

class _BodyTemperatureScreenState extends State<BodyTemperatureScreen> {
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
