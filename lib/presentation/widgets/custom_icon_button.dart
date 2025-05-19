// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:fusion_news_app/core/theme/app_palette.dart';

class CustomIconButton extends StatelessWidget {
  final IconData buttonIcon;
  const CustomIconButton({Key? key, required this.buttonIcon})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Pallete.white,
        side: BorderSide(color: Pallete.backgroundColor, width: 2.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
        minimumSize: Size.zero,
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Icon(buttonIcon, color: Pallete.backgroundColor, size: 25),
      ),
    );
  }
}
