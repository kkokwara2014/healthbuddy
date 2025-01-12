import 'package:flutter/material.dart';

class DocHomeScreen extends StatefulWidget {
  const DocHomeScreen({super.key});

  @override
  State<DocHomeScreen> createState() => _DocHomeScreenState();
}

class _DocHomeScreenState extends State<DocHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text("Home Screen"),
      ),
    );
  }
}
