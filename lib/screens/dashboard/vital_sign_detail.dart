import 'package:flutter/material.dart';
import 'package:health_buddy/models/vital_sign_model.dart';

class VitalSignDetailScreen extends StatelessWidget {
  const VitalSignDetailScreen({super.key, required this.vitalSignModel});
  final VitalSignModel vitalSignModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("${vitalSignModel.name} Details"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton.small(
          onPressed: () {},
          child: const Icon(Icons.add),
        ));
  }
}
