import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/core/theme/app_palette.dart';
import 'package:fusion_news_app/features/auth/bloc/signup_page_bloc.dart';
import 'package:fusion_news_app/features/auth/bloc/auth_event.dart';
import 'package:fusion_news_app/features/auth/bloc/auth_state.dart';
import 'package:fusion_news_app/features/auth/view/pages/login_page.dart';
import 'package:fusion_news_app/features/auth/view/widgets/auth_button.dart';
import 'package:fusion_news_app/features/auth/view/widgets/custom_field.dart';
import 'package:fusion_news_app/presentation/pages/main_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<SignupPage> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordVerifierController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupPageBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MainPage()),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Kayit basarisiz lutfen tekrar deneyin')),
          );
        }
      },
      child: Scaffold(
        backgroundColor: Pallete.backgroundColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 250,
                      child: Image.asset('assets/images/plain_logo.png'),
                    ),
                    Text(
                      'Let\'s start to create your Fusion!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(right: 24.0, left: 24.0),
              child: Container(
                width: 275,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CustomField(
                      hintText: 'Enter your Name',
                      controller: nameController,
                      icon: Icon(Icons.person),
                    ),
                    CustomField(
                      hintText: 'Enter your E-mail',
                      controller: emailController,
                      icon: Icon(Icons.mail),
                    ),
                    CustomField(
                      icon: Icon(Icons.lock),
                      hintText: 'Create a Password',
                      isObscureText: true,
                      controller: passwordController,
                    ),
                    CustomField(
                      icon: Icon(Icons.lock),
                      hintText: 'Verify your Password',
                      isObscureText: true,
                      controller: passwordVerifierController,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(27.0),
              child: Column(
                children: [
                  Container(
                    width: 160,
                    height: 45,
                    child: AuthButton(
                      buttonName: 'SIGN UP',
                      onTap: () {
                        final email = emailController.text;
                        final password = passwordController.text;
                        final name = nameController.text;

                        context.read<SignupPageBloc>().add(
                          SignUpRequested(
                            email: email,
                            password: password,
                            name: name,
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account?',
                        children: [
                          TextSpan(
                            style: TextStyle(color: Pallete.onBackgroundColor),
                            text: ' Sign in.',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
