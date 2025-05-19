import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/core/theme/app_palette.dart';
import 'package:fusion_news_app/features/auth/bloc/auth_event.dart';
import 'package:fusion_news_app/features/auth/bloc/auth_state.dart';
import 'package:fusion_news_app/features/auth/bloc/signin_page_bloc.dart';
import 'package:fusion_news_app/features/auth/view/pages/reset_password_page.dart';
import 'package:fusion_news_app/features/auth/view/pages/signup_page.dart';
import 'package:fusion_news_app/features/auth/view/widgets/auth_button.dart';
import 'package:fusion_news_app/features/auth/view/widgets/custom_field.dart';
import 'package:fusion_news_app/presentation/pages/main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SigninPageBloc, AuthState>(
      listener: (context, state) {
        if (state is Authenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MainPage()),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Giris basarisiz lutfen tekrar deneyin')),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hello',
                      style: TextStyle(
                        fontFamily: 'Spartan',
                        fontSize: 60,
                        height: 0.95,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Welcome back to Fusion!',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        height: 1,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Container(
                  width: 125,
                  height: 125,
                  child: Image.asset('assets/images/app_icon.png'),
                ),
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
                    CustomField(
                      icon: Icon(Icons.lock),
                      hintText: 'Password',
                      controller: passwordController,
                      isObscureText: true,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ResetPasswordPage(),
                          ),
                        );
                      },
                      child: Text(
                        'Forgot your password?',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          color: Pallete.white,
                        ),
                      ),
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
                      buttonName: 'SIGN IN',
                      onTap: () {
                        final email = emailController.text;
                        final password = passwordController.text;

                        context.read<SigninPageBloc>().add(
                          SignInRequested(email: email, password: password),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SignupPage()),
                      );
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Don\'t have an account?',
                        children: [
                          TextSpan(
                            style: TextStyle(color: Pallete.onBackgroundColor),
                            text: ' Sign up.',
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
