import 'package:flutter/material.dart';
import 'package:fusion_news_app/core/theme/app_palette.dart';
import 'package:fusion_news_app/features/auth/view/widgets/auth_button.dart';
import 'package:fusion_news_app/features/auth/view/widgets/custom_field.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<ResetPasswordPage> {
  final emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Pallete.backgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reset your password.',
                    style: TextStyle(
                      fontFamily: 'Spartan',
                      fontSize: 30,
                      height: 0.95,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'We will send you a verfication code.',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 14,
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 65),

              // Container(
              //   width: 125,
              //   height: 125,
              //   child: Image.asset('assets/images/app_icon.png'),
              // ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 24.0, left: 24.0),
            child: Container(
              width: 275,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CustomField(
                    hintText: 'E-mail',
                    controller: emailController,
                    icon: Icon(Icons.mail),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(27.0),
            child: Column(
              children: [
                SizedBox(
                  width: 160,
                  height: 45,
                  child: AuthButton(buttonName: 'SEND', onTap: () => {}),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
