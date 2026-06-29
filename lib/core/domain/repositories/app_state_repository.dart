abstract class AppStateRepository {
  Future<bool> hasSeenOnboarding();
  Future<void> setOnboardingSeen();
  bool isLoggedIn();
}
