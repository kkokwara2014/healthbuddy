import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/images.dart';
import 'package:health_buddy/constants/loading.dart';
import 'package:health_buddy/providers/auth_user_provider.dart';
import 'package:health_buddy/screens/authentication/check_loggedin.dart';
import 'package:health_buddy/screens/authentication/sign_up_options.dart';
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

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthUserProvider>(context);
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
                    controller: emailController,
                    hideText: false,
                    hintText: "Email",
                    prefixicon: Icons.email,
                    textInputType: TextInputType.emailAddress,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  MyTextInput(
                    controller: passwordController,
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
                      if (_formKey.currentState!.validate()) {
                        showLoadingDialog(context);
                        try {
                          await authProvider.signIn(emailController.text.trim(),
                              passwordController.text.trim());
                          Get.offAll(() => const CheckLoggedInUser());
                          Get.rawSnackbar(message: "Login successful!");
                        } on FirebaseAuthException catch (e) {
                          Get.rawSnackbar(message: e.toString());
                        }
                        // if (mounted) {
                        // hideLoadingDialog(context);
                        // }
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
                            // Get.to(() => const RegisterScreen());
                            Get.to(() => const SignUpOptionScreen());
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
