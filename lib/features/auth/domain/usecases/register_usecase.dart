import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<UserEntity> execute({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required int avatar,
  }) async {
    return await repository.register(
        name, email, password, phoneNumber, avatar);
  }
}
