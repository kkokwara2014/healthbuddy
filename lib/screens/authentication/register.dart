import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/images.dart';
import 'package:health_buddy/providers/auth_provider.dart';
import 'package:health_buddy/screens/authentication/login.dart';
import 'package:health_buddy/screens/dashboard/landing_page.dart';
import 'package:health_buddy/widgets/button_widget.dart';
import 'package:health_buddy/widgets/text_input.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(appLogo,
                      width: 90, height: 90, fit: BoxFit.cover),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyTextInput(
                    controller: authProvider.nameController,
                    hideText: false,
                    hintText: "Name",
                    prefixicon: Icons.person_2_outlined,
                    textInputType: TextInputType.name,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextInput(
                    controller: authProvider.emailController,
                    hideText: false,
                    hintText: "Email",
                    prefixicon: Icons.email,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextInput(
                    controller: authProvider.phoneController,
                    hideText: false,
                    hintText: "Phone",
                    prefixicon: Icons.phone,
                    textInputType: TextInputType.phone,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextInput(
                    controller: authProvider.passwordController,
                    hideText: true,
                    hintText: "Password",
                    prefixicon: Icons.lock,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextInput(
                    controller: authProvider.confirmPasswordController,
                    hideText: true,
                    hintText: "Confirm Password",
                    prefixicon: Icons.lock,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        if (authProvider.passwordController.text !=
                            authProvider.confirmPasswordController.text) {
                          Get.rawSnackbar(
                              message:
                                  "Confirm password did not match with password!");
                        } else {
                          authProvider.signUp();
                          Get.offAll(() => const LandingPage());
                          Get.rawSnackbar(message: "Signed up successfully!");
                        }
                      }
                    },
                    text: "Sign Up",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      TextButton(
                          onPressed: () {
                            Get.to(() => const LoginScreen());
                          },
                          child: const Text("Sign In")),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
