import 'package:flutter/material.dart';
import 'package:health_buddy/models/vital_sign_model.dart';

class HeartRateScreen extends StatefulWidget {
  const HeartRateScreen({super.key, required this.vitalSignModel});
  final VitalSignModel vitalSignModel;

  @override
  State<HeartRateScreen> createState() => _HeartRateScreenState();
}

class _HeartRateScreenState extends State<HeartRateScreen> {
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
