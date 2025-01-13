import 'package:health_buddy/constants/images.dart';

class VitalSignModel {
  final String image;
  final String name;
  final String storedname;
  final String description;

  VitalSignModel(
      {required this.image,
      required this.name,
      required this.storedname,
      required this.description});
}

List<VitalSignModel> vitalSigns = [
  VitalSignModel(
      image: bpImage,
      name: "Blood Pressure",
      storedname: "bloodpressures",
      description: "Check your BP"),
  VitalSignModel(
      image: heartRateImage,
      name: "Heart Rate",
      storedname: "heartrates",
      description: "Check your Heart rate"),
  VitalSignModel(
      image: respiratoryImage,
      name: "Respiratory Rate",
      storedname: "respiratoryrates",
      description: "Check your Respiratory rate"),
  VitalSignModel(
      image: temperatureImage,
      name: "Body Temperature",
      storedname: "bodytemperatures",
      description: "Check your Temperature"),
  VitalSignModel(
      image: bmiImage,
      name: "Body Mass Index",
      storedname: "bmis",
      description: "Check your BMI"),
];
