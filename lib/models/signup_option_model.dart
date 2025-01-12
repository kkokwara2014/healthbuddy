import 'package:health_buddy/constants/images.dart';

class SignupOptionModel {
  final String image;
  final String name;

  SignupOptionModel({required this.image, required this.name});
}

List<SignupOptionModel> signupOptions = [
  SignupOptionModel(image: doctorImage, name: "Doctor"),
  SignupOptionModel(image: patientImage, name: "User"),
];
