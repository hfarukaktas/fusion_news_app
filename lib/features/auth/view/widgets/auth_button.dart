import 'package:flutter/material.dart';
import 'package:fusion_news_app/core/theme/app_palette.dart';

class AuthButton extends StatelessWidget {
  final String buttonName;
  final VoidCallback onTap;

  const AuthButton({super.key, required this.buttonName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
        fixedSize: Size(395, 55),
        backgroundColor: Pallete.onBackgroundColor,
        shadowColor: Colors.transparent,
      ),
      onPressed: onTap,
      child: Text(
        buttonName,
        style: const TextStyle(
          color: Pallete.black,
          fontFamily: 'Oswald',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
