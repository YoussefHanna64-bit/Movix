import 'package:movix/features/profile/domain/repositories/profile_repository.dart';

class ToggleWishlistUseCase {
  final ProfileRepository repository;

  ToggleWishlistUseCase(this.repository);

  Future<void> execute({required int movieId, required bool isAdding}) async {
    return await repository.toggleWishlist(movieId, isAdding);
  }
}
