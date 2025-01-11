import 'package:health_buddy/constants/images.dart';

class OnboardModel {
  final String image;
  final String title;
  final String subtitle;

  OnboardModel(
      {required this.image, required this.title, required this.subtitle});
}

List<OnboardModel> onboardLists = [
  OnboardModel(
      image: healthcheckImage,
      title: "Manage Your Health",
      subtitle: "Get control of your health by knowing your medical details."),
  OnboardModel(
      image: appointmentImage,
      title: "Control Your Appointments",
      subtitle:
          "Schedule and get response on your medical appointments by a medical professional."),
  OnboardModel(
      image: medicalprofImage,
      title: "Reach a Medical Practitioner",
      subtitle: "Get in touch with a medical practitioner with ease."),
];
