import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/di/injection_container.dart' as di;
import 'package:movix/features/movies/presentation/cubit/movies_cubit.dart';
import 'package:movix/features/auth/presentation/screens/login_screen.dart';
import 'package:movix/features/auth/presentation/screens/register_screen.dart';
import 'package:movix/features/profile/presentation/screens/update_profile_screen.dart';
import 'package:movix/features/splash/presentation/screens/splash_screen.dart';
import 'package:movix/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:movix/features/layout/presentation/screens/layout_screen.dart';
import 'package:movix/features/movies/presentation/screens/movie_details_screen.dart';
import 'app_routes.dart';

class AppPages {
  static Map<String, WidgetBuilder> get routes => {
        AppRoutes.splash: (context) => const SplashScreen(),
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.login: (context) => const LoginScreen(),
        AppRoutes.register: (context) => const RegisterScreen(),
        AppRoutes.layout: (context) => const LayoutScreen(),
        AppRoutes.movieDetails: (context) => BlocProvider(
              create: (_) => di.sl<MoviesCubit>(),
              child: const MovieDetailsScreen(),
            ),
        AppRoutes.updateProfile: (context) => const UpdateProfileScreen(),
      };
}

