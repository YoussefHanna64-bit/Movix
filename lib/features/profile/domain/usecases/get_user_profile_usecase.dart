import 'package:movix/features/auth/domain/entities/user_entity.dart';
import 'package:movix/features/profile/domain/repositories/profile_repository.dart';

class GetUserProfileUseCase {
  final ProfileRepository repository;

  GetUserProfileUseCase(this.repository);

  Future<UserEntity> execute() async {
    return await repository.getUserProfile();
  }
}
