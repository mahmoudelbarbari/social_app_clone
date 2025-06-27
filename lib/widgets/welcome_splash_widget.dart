import 'dart:async';
import 'package:flutter/material.dart';
import 'package:social_app_clone/auth/register_page.dart.dart';

class WelcomeSplashWidget extends StatefulWidget {
  const WelcomeSplashWidget({super.key});

  @override
  State<WelcomeSplashWidget> createState() => _WelcomeSplashWidgetState();
}

class _WelcomeSplashWidgetState extends State<WelcomeSplashWidget> {
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 4),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Image.asset('assets/images/splash_screen.gif'),
    );
  }
}
