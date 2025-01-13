import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:health_buddy/models/bmi_model.dart';

class BMIProvider extends ChangeNotifier {
  final _firestore = FirebaseFirestore.instance;
  final _userId = FirebaseAuth.instance.currentUser!.uid;
  double _bmi = 0;
  String _bmiReport = "";
  double get bmi => _bmi;
  String get bmiReport => _bmiReport;

//calculate BMI
  void calculateBMI(String heightinput, String weightinput) {
    final double height = double.tryParse(heightinput) ?? 0;
    final double weight = double.tryParse(weightinput) ?? 0;
    if (height > 0 && weight > 0) {
      _bmi = weight / (height * height) * 10000;
      if (_bmi < 18.5) {
        _bmiReport = "You are underweight\n(BMI less than 18.5)";
      } else if (_bmi >= 18.5 && _bmi < 24.9) {
        _bmiReport = "You have normal weight\n(BMI 18.5 - 24.9)";
      } else if (_bmi >= 25 && _bmi < 30) {
        _bmiReport = "You are overweight\n(BMI 25 - 29.9)";
      } else {
        _bmiReport = "Obesity\n(BMI 30 or higher)";
      }
      notifyListeners();
    }
  }

//save BMI
  Future<void> saveBMI(
    String height,
    String weight,
    String report,
  ) async {
    final newBmi = BmiModel(
        uid: _userId,
        height: height,
        weight: weight,
        report: report,
        created: DateTime.now().toString().split(" ")[0]);
    await _firestore.collection("bmis").add(newBmi.toMap());
    notifyListeners();
  }

  //delete BMI
  Future<void> deleteBMI(String bmiId) async {
    await _firestore.collection("bmis").doc(bmiId).delete();
    notifyListeners();
  }
}
