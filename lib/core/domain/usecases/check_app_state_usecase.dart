import '../repositories/app_state_repository.dart';

class AppStateResult {
  final bool hasSeenOnboarding;
  final bool isLoggedIn;

  AppStateResult({required this.hasSeenOnboarding, required this.isLoggedIn});
}

class CheckAppStateUseCase {
  final AppStateRepository repository;

  CheckAppStateUseCase(this.repository);

  Future<AppStateResult> execute() async {
    final hasSeenOnboarding = await repository.hasSeenOnboarding();
    final isLoggedIn = repository.isLoggedIn();
    return AppStateResult(hasSeenOnboarding: hasSeenOnboarding, isLoggedIn: isLoggedIn);
  }
}
