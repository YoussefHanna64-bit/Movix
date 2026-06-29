import 'package:movix/features/auth/domain/repositories/auth_repository.dart';

class ForgetPasswordUseCase {
  final AuthRepository repository;

  ForgetPasswordUseCase(this.repository);

  Future<void> execute(String email) async {
    return await repository.forgetPassword(email);
  }
}
