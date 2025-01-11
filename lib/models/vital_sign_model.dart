import 'package:health_buddy/constants/images.dart';

class VitalSignModel {
  final String image;
  final String name;
  final String description;

  VitalSignModel(
      {required this.image, required this.name, required this.description});
}

List<VitalSignModel> vitalSigns = [
  VitalSignModel(
      image: bpImage, name: "Blood Pressure", description: "Check your BP"),
  VitalSignModel(
      image: heartRateImage,
      name: "Heart Rate",
      description: "Check your Heart rate"),
  VitalSignModel(
      image: respiratoryImage,
      name: "Respiratory Rate",
      description: "Check your Respiratory rate"),
  VitalSignModel(
      image: temperatureImage,
      name: "Body Temperature",
      description: "Check your Temperature"),
  VitalSignModel(
      image: bmiImage, name: "Body Mass Index", description: "Check your BMI"),
];
