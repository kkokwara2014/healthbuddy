import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/models/signup_option_model.dart';
import 'package:health_buddy/screens/authentication/login.dart';
import 'package:health_buddy/screens/authentication/register.dart';

class SignUpOptionScreen extends StatefulWidget {
  const SignUpOptionScreen({super.key});

  @override
  State<SignUpOptionScreen> createState() => _SignUpOptionScreenState();
}

class _SignUpOptionScreenState extends State<SignUpOptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "Sign Up Option",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ...List.generate(
                signupOptions.length,
                (index) => GestureDetector(
                  onTap: () {
                    Get.to(() => RegisterScreen(
                          signupOptionModel: signupOptions[index],
                        ));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            signupOptions[index].image,
                            width: 90,
                            height: 90,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          signupOptions[index].name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const LoginScreen());
                    },
                    child: const Text("Sign In"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
