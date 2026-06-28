import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> login(String email, String password);
  Future<UserEntity> register(String name, String email, String password,
      String phoneNumber, int avatar);
  Future<void> logout();
  Future<void> forgetPassword(String email);
  Future<void> changePassword(String newPassword);
  Future<void> deleteAccount();
}
