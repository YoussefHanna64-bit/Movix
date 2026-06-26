import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> login(String email, String password) async {
    try {
      final userModel = await remoteDataSource.login(email, password);
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Authentication failed');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<UserEntity> register(String name, String email, String password,
      String phoneNumber, int avatar) async {
    try {
      final userModel = await remoteDataSource.register(
          name, email, password, phoneNumber, avatar);
      return userModel;
    } on FirebaseAuthException catch (e) {
      throw Exception(e.message ?? 'Registration failed');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> forgetPassword(String email) async {
    try {
      await remoteDataSource.forgetPassword(email);
    } on FirebaseAuthException catch (e) {
      // You can customize these error messages based on e.code
      throw Exception(e.message ?? 'Failed to send password reset email.');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await remoteDataSource.logout();
    } catch (e) {
      throw Exception('Failed to logout');
    }
  }
}
