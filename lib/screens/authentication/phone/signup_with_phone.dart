import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/images.dart';
import 'package:health_buddy/screens/authentication/phone/verify_otp_screen.dart';
import 'package:health_buddy/screens/authentication/sign_up_options.dart';
import 'package:health_buddy/widgets/button_widget.dart';
import 'package:health_buddy/widgets/loading_spinner.dart';
import 'package:health_buddy/widgets/text_input.dart';

class SignupWithPhoneScreen extends StatefulWidget {
  const SignupWithPhoneScreen({super.key});

  @override
  State<SignupWithPhoneScreen> createState() => _SignupWithPhoneScreenState();
}

class _SignupWithPhoneScreenState extends State<SignupWithPhoneScreen> {
  final _formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();

  //laoding variable
  bool isLoading = false;

  @override
  void dispose() {
    phoneController.dispose();

    super.dispose();
  }

  Future<void> submitPhone(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential cred) {},
        verificationFailed: (FirebaseAuthException e) {
          print(e.message.toString());
        },
        codeSent: (String verificationId, int? resendToken) {
          Get.to(() => VerifyOTPScreen(
                verificationId: verificationId,
              ));
        },
        codeAutoRetrievalTimeout: (String verificationId) {});
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingSpinner(
            text: "Authenticating phone...",
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(appLogo,
                            width: 90, height: 90, fit: BoxFit.cover),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Phone Authentication",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyTextInput(
                          controller: phoneController,
                          hideText: false,
                          hintText: "Phone",
                          prefixicon: Icons.phone,
                          textInputType: TextInputType.phone,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(15)
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        MyButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              try {
                                setState(() {
                                  isLoading = true;
                                });
                                //call the method for sending OTP here
                                submitPhone(context);
                                setState(() {
                                  isLoading = false;
                                });
                                // Get.offAll(() => const CheckLoggedInUser());
                              } on FirebaseAuthException catch (e) {
                                setState(() {
                                  isLoading = false;
                                });
                                Get.rawSnackbar(message: e.toString());
                              }
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
