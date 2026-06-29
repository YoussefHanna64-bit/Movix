import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/repositories/app_state_repository.dart';

class AppStateRepositoryImpl implements AppStateRepository {
  final FirebaseAuth firebaseAuth;
  final SharedPreferences sharedPreferences;

  AppStateRepositoryImpl({
    required this.firebaseAuth,
    required this.sharedPreferences,
  });

  @override
  Future<bool> hasSeenOnboarding() async {
    return sharedPreferences.getBool('has_seen_onboarding') ?? false;
  }

  @override
  Future<void> setOnboardingSeen() async {
    await sharedPreferences.setBool('has_seen_onboarding', true);
  }

  @override
  bool isLoggedIn() {
    return firebaseAuth.currentUser != null;
  }
}
