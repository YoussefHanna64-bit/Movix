import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/routes/app_routes.dart';
import 'package:movix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:movix/core/di/injection_container.dart' as di;
import 'package:movix/core/domain/usecases/check_app_state_usecase.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndOnboarding();
  }

  Future<void> _checkAuthAndOnboarding() async {
    final checkAppState = di.sl<CheckAppStateUseCase>();
    final result = await checkAppState.execute();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      if (!result.hasSeenOnboarding) {
        Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
        return;
      }
      
      if (result.isLoggedIn) {
        if (context.mounted) {
          context.read<ProfileCubit>().loadProfile();
        }
        Navigator.pushReplacementNamed(context, AppRoutes.layout);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.login);
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
