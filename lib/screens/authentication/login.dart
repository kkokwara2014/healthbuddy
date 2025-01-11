import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/images.dart';
import 'package:health_buddy/providers/auth_provider.dart';
import 'package:health_buddy/screens/authentication/register.dart';
import 'package:health_buddy/screens/dashboard/landing_page.dart';
import 'package:health_buddy/widgets/button_widget.dart';
import 'package:health_buddy/widgets/text_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(appLogo,
                      width: 90, height: 90, fit: BoxFit.cover),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Sign In",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
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
                    controller: authProvider.passwordController,
                    hideText: true,
                    hintText: "Password",
                    prefixicon: Icons.lock,
                    textInputType: TextInputType.text,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  MyButton(
                    onPressed: () async {
                      // Get.to(() => const LandingPage());
                      if (_formKey.currentState!.validate()) {
                        await authProvider.signIn();
                        Get.offAll(() => const LandingPage());
                        Get.rawSnackbar(message: "Login successful!");
                      }
                    },
                    text: "Sign In",
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      TextButton(
                          onPressed: () {
                            Get.to(() => const RegisterScreen());
                          },
                          child: const Text("Sign Up")),
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
