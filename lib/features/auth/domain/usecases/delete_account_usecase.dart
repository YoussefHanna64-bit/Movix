import 'package:movix/features/auth/domain/repositories/auth_repository.dart';

class DeleteAccountUseCase {
  final AuthRepository repository;

  DeleteAccountUseCase(this.repository);

  Future<void> execute() async {
    return await repository.deleteAccount();
  }
}
