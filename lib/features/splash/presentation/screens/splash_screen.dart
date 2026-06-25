import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:movix/core/routes/app_routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to OnboardingScreen after a 3-second delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: ZoomIn(
          duration: const Duration(seconds: 1),
          animate: true,
          child: Center(
            child: Image.asset(
              'assets/images/splash_screen_movie_logo.jpg',
              width: 300,
              height: 300,
            ),
          ),
        ),
      ),
    );
  }
}
