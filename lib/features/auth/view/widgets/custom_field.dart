import 'package:flutter/material.dart';
import 'package:fusion_news_app/core/theme/app_palette.dart';

class CustomField extends StatelessWidget {
  final Icon icon;
  final bool isObscureText;
  final String hintText;
  final TextEditingController controller;
  const CustomField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.controller,
    this.isObscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isObscureText,
      controller: controller,
      style: TextStyle(color: Pallete.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Pallete.white),
        prefixIcon: icon,
        prefixIconColor: Pallete.white,
      ),
      validator: (value) {
        if (value!.trim().isEmpty) {
          return "$hintText is missing!";
        } else {
          return null;
        }
      },
    );
  }
}
