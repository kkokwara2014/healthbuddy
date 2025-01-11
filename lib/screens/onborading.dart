import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/color.dart';
import 'package:health_buddy/constants/images.dart';
import 'package:health_buddy/screens/authentication/login.dart';
import 'package:health_buddy/widgets/button_widget.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                appLogo,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              const Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: "Health",
                      style: TextStyle(
                        color: pkColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 35,
                      )),
                  TextSpan(
                    text: "Buddy",
                    style: TextStyle(
                      color: hTxtColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 35,
                    ),
                  ),
                ]),
              ),
              horizontalLine(),
              const SizedBox(height: 5),
              descriptionText(),
              const SizedBox(
                height: 5,
              ),
            ],
          ),
        ),
      ),
      bottomSheet: MyButton(
          text: "Get Started",
          onPressed: () {
            Get.to(() => const LoginScreen());
          }),
    );
  }

  Padding descriptionText() {
    return const Padding(
      padding: EdgeInsets.all(12.0),
      child: Text(
        textAlign: TextAlign.center,
        "Your health companion in managing your health information! Manage your health details with Health Buddy and get the benefits of the App.",
        style: TextStyle(
          color: Colors.black45,
          fontSize: 16,
        ),
      ),
    );
  }

  Row horizontalLine() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: 70,
          height: 5,
          decoration: const BoxDecoration(color: hTxtColor),
        ),
        Container(
          width: 70,
          height: 5,
          decoration: const BoxDecoration(color: pkColor),
        ),
      ],
    );
  }
}
