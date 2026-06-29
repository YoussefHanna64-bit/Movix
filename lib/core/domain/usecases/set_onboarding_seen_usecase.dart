import '../repositories/app_state_repository.dart';

class SetOnboardingSeenUseCase {
  final AppStateRepository repository;

  SetOnboardingSeenUseCase(this.repository);

  Future<void> execute() async {
    await repository.setOnboardingSeen();
  }
}
