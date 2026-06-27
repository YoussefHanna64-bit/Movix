import 'package:movix/features/profile/domain/repositories/profile_repository.dart';

class AddToHistoryUseCase {
  final ProfileRepository repository;

  AddToHistoryUseCase(this.repository);

  Future<void> execute(int movieId) async {
    return await repository.addToHistory(movieId);
  }
}
