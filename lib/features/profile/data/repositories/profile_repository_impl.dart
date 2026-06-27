import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movix/features/auth/domain/entities/user_entity.dart';
import 'package:movix/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:movix/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;

  ProfileRepositoryImpl({required this.remoteDataSource});

  @override
  Future<UserEntity> getUserProfile() async {
    try {
      return await remoteDataSource.getUserProfile();
    } on FirebaseException catch (e) {
      throw Exception("Failed to load profile: ${e.message}");
    } catch (e) {
      throw Exception("Failed to load profile: ${e.toString()}");
    }
  }

  @override
  Future<void> updateUserProfile(
      {required String name,
      required int avatar,
      required String phoneNumber}) async {
    try {
      await remoteDataSource.updateUserProfile(
          name: name, avatar: avatar, phoneNumber: phoneNumber);
    } on FirebaseException catch (e) {
      throw Exception("Failed to update profile: ${e.message}");
    } catch (e) {
      throw Exception("Failed to update profile: ${e.toString()}");
    }
  }

  @override
  Future<void> toggleWishlist(int movieId, bool isAdding) async {
    try {
      await remoteDataSource.toggleWishlist(movieId, isAdding);
    } on FirebaseException catch (e) {
      throw Exception("Failed to update wishlist: ${e.message}");
    } catch (e) {
      throw Exception("Failed to update wishlist: ${e.toString()}");
    }
  }

  @override
  Future<void> addToHistory(int movieId) async {
    try {
      await remoteDataSource.addToHistory(movieId);
    } on FirebaseException catch (e) {
      throw Exception("Failed to add to the history: ${e.message}");
    } catch (e) {
      throw Exception("Failed to add to the history: ${e.toString()}");
    }
  }
}
