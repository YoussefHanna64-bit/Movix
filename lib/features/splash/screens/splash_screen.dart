import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0xff121312),
        ),
        child: ZoomIn(
          duration: Duration(seconds: 1),
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
