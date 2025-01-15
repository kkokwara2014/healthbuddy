import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/images.dart';
import 'package:health_buddy/models/signup_option_model.dart';
import 'package:health_buddy/providers/auth_user_provider.dart';
import 'package:health_buddy/screens/authentication/check_loggedin.dart';
import 'package:health_buddy/screens/authentication/login.dart';
import 'package:health_buddy/widgets/button_widget.dart';
import 'package:health_buddy/widgets/loading_spinner.dart';
import 'package:health_buddy/widgets/text_input.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key, required this.signupOptionModel});
  final SignupOptionModel signupOptionModel;

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  //getting inputs from the user
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  //loading variable
  bool isLoading = false;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthUserProvider>(context);
    return isLoading
        ? const LoadingSpinner(
            text: "Creating account...",
          )
        : Scaffold(
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
                        Text(
                          "Sign Up as ${widget.signupOptionModel.name}",
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextInput(
                          controller: nameController,
                          hideText: false,
                          hintText: "Name",
                          prefixicon: Icons.person_2_outlined,
                          textInputType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 10,
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
                          controller: phoneController,
                          hideText: false,
                          hintText: "Phone",
                          prefixicon: Icons.phone,
                          textInputType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(11)
                          ],
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
                          height: 10,
                        ),
                        MyTextInput(
                          controller: confirmPasswordController,
                          hideText: true,
                          hintText: "Confirm Password",
                          prefixicon: Icons.lock,
                          textInputType: TextInputType.text,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                isLoading = true;
                              });
                              await Future.delayed(const Duration(seconds: 5));

                              if (passwordController.text !=
                                  confirmPasswordController.text) {
                                Get.rawSnackbar(
                                    message:
                                        "Confirm password did not match with password!");
                              } else {
                                try {
                                  authProvider.signUp(
                                      nameController.text.trim(),
                                      emailController.text.trim(),
                                      phoneController.text.trim(),
                                      passwordController.text.trim(),
                                      widget.signupOptionModel.name);

                                  //remove the loading spinner
                                  Get.offAll(() => const CheckLoggedInUser());
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Get.rawSnackbar(
                                      message: "Signed up successfully!");
                                } on FirebaseAuthException catch (e) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Get.rawSnackbar(message: e.toString());
                                }
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
