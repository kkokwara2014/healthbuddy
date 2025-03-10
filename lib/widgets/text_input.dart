// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixicon;
  final bool hideText;
  final TextInputType textInputType;
  final List<TextInputFormatter>? inputFormatters;
  const MyTextInput(
      {Key? key,
      required this.controller,
      required this.hintText,
      required this.prefixicon,
      required this.hideText,
      required this.textInputType,
      this.inputFormatters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      inputFormatters: inputFormatters,
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
