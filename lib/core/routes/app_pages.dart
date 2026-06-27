import 'package:flutter/material.dart';
import 'package:movix/features/splash/presentation/screens/splash_screen.dart';
import 'package:movix/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:movix/features/layout/presentation/screens/layout_screen.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.layout: (context) => const LayoutScreen(),
      };
}
