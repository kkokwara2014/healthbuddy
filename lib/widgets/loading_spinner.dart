import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:health_buddy/constants/color.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pkColor[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: blackColor,
                fontSize: 18,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const Text(
              "Please, wait!",
              style: TextStyle(
                color: blackColor,
                fontSize: 16,
                fontWeight: FontWeight.w300,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SpinKitChasingDots(
              color: pkColor,
              size: 40,
            ),
          ],
        ),
      ),
    );
  }
}
