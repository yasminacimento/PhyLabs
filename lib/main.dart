import 'package:flutter/material.dart';

import 'core/theme/app_theme.dart';
import 'features/auth/presentation/forgot_password_screen.dart';
import 'features/auth/presentation/login_screen.dart';
import 'features/auth/presentation/register_screen.dart';
import 'features/home/presentation/home_screen.dart';

void main() {
  runApp(const PhyLabsApp());
}

class PhyLabsApp extends StatelessWidget {
  const PhyLabsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PhyLabs',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      initialRoute: LoginScreen.routeName,
      routes: {
        LoginScreen.routeName: (context) => const LoginScreen(),
        RegisterScreen.routeName: (context) => const RegisterScreen(),
        ForgotPasswordScreen.routeName: (context) =>
            const ForgotPasswordScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
      },
    );
  }
}
