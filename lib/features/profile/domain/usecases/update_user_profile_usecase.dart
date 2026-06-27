import 'package:movix/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserProfileUseCase {
  final ProfileRepository repository;

  UpdateUserProfileUseCase(this.repository);

  Future<void> execute(
      {required String name,
      required int avatar,
      required String phoneNumber}) async {
    return await repository.updateUserProfile(
        name: name, avatar: avatar, phoneNumber: phoneNumber);
  }
}
