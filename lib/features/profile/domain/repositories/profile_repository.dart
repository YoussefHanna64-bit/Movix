import 'package:movix/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUserProfile();
  Future<void> updateUserProfile(
      {required String name, required int avatar, required String phoneNumber});
  Future<void> toggleWishlist(int movieId, bool isAdding);
  Future<void> addToHistory(int movieId);
}
