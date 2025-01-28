import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:health_buddy/constants/images.dart';
import 'package:health_buddy/screens/authentication/phone/signup_with_phone.dart';
import 'package:health_buddy/screens/dashboard/home_screen.dart';
import 'package:health_buddy/widgets/button_widget.dart';
import 'package:health_buddy/widgets/loading_spinner.dart';
import 'package:health_buddy/widgets/text_input.dart';

class VerifyOTPScreen extends StatefulWidget {
  const VerifyOTPScreen({super.key, required this.verificationId});
  final String verificationId;

  @override
  State<VerifyOTPScreen> createState() => _VerifyOTPScreenState();
}

class _VerifyOTPScreenState extends State<VerifyOTPScreen> {
  final _formKey = GlobalKey<FormState>();

  final otpController = TextEditingController();

  //laoding variable
  bool isLoading = false;

  @override
  void dispose() {
    otpController.dispose();

    super.dispose();
  }

  Future<void> verifyOTP(BuildContext context) async {
    final auth = FirebaseAuth.instance;
    try {
      PhoneAuthCredential cred = PhoneAuthProvider.credential(
          verificationId: widget.verificationId,
          smsCode: otpController.text.trim());
      await auth.signInWithCredential(cred);
      Get.offAll(() => const HomeScreen());
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const LoadingSpinner(
            text: "Signing up...",
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
                          controller: otpController,
                          hideText: false,
                          hintText: "OTP",
                          prefixicon: Icons.numbers,
                          textInputType: TextInputType.number,
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
                          text: "Verify OTP",
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
                                  // Get.to(() => const RegisterScreen());
                                  Get.to(() => const SignupWithPhoneScreen());
                                },
                                child: const Text("Phone Authentication")),
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
