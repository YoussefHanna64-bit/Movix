import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:movix/core/theme/app_theme.dart';
import 'package:movix/core/routes/app_pages.dart';
import 'package:movix/core/routes/app_routes.dart';
import 'package:movix/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:movix/firebase_options.dart';
import 'package:movix/core/di/injection_container.dart' as di;
import 'package:movix/features/home/presentation/cubit/home_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()),
        BlocProvider(create: (_) => di.sl<HomeCubit>()..loadHome()),
        BlocProvider(create: (_) => di.sl<ProfileCubit>()),
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.darkTheme,
        initialRoute: AppRoutes.splash,
        routes: AppPages.routes,
      ),

    );
  }
}
