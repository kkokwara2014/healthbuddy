// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class MyTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixicon;
  final bool hideText;
  final TextInputType textInputType;
  const MyTextInput({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.prefixicon,
    required this.hideText,
    required this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: hideText,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is required";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        prefixIcon: Icon(prefixicon),
        hintText: hintText,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.all(17),
      ),
      keyboardType: textInputType,
    );
  }
}
