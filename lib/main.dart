import 'package:flutter/material.dart';
import 'package:fusion_news_app/core/theme/theme.dart';
import 'package:fusion_news_app/features/auth/bloc/signin_page_bloc.dart';
import 'package:fusion_news_app/features/auth/services/user_service.dart';
import 'package:fusion_news_app/features/auth/view/pages/signup_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/features/auth/bloc/signup_page_bloc.dart';
import 'package:fusion_news_app/features/auth/services/auth_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => SignupPageBloc(
                authRepository: AuthService(),
                userService: UserService(),
              ),
        ),
        BlocProvider(
          create: (context) => SigninPageBloc(authRepository: AuthService()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(theme: AppTheme.lightThemeMode, home: SignupPage());
  }
}
