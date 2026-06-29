import 'package:movix/features/auth/domain/entities/user_entity.dart';
import 'package:movix/features/home/domain/entities/movie_entity.dart';

abstract class ProfileRepository {
  Future<UserEntity> getUserProfile();
  Future<void> updateUserProfile(
      {required String name, required int avatar, required String phoneNumber});
  Future<void> toggleWishlist(int movieId, bool isAdding);
  Future<void> addToHistory(int movieId);
  Future<MovieEntity> getMovieById(int id);
  Future<List<MovieEntity>> getMoviesByIds(List<int> ids);
}
