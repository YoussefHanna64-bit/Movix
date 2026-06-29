import 'package:movix/features/auth/domain/repositories/auth_repository.dart';

class ChangePasswordUseCase {
  final AuthRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<void> execute(String newPassword) async {
    return await repository.changePassword(newPassword);
  }
}
