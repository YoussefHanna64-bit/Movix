import 'package:movix/core/error/failure.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movix/core/network/dio_client.dart';
import 'package:movix/features/auth/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<UserModel> getUserProfile();
  Future<void> updateUserProfile(
      {required String name, required int avatar, required String phoneNumber});
  Future<void> toggleWishlist(int movieId, bool isAdding);
  Future<void> addToHistory(int movieId);
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final FirebaseFirestore firestore;
  final FirebaseAuth firebaseAuth;
  final DioClient dioClient;

  ProfileRemoteDataSourceImpl({
    required this.firestore,
    required this.firebaseAuth,
    required this.dioClient,
  });

  String get _currentUid {
    final user = firebaseAuth.currentUser;

    if (user == null) {
      throw const Failure('User is not logged in');
    }

    return user.uid;
  }

  @override
  Future<UserModel> getUserProfile() async {
    final user = await firestore.collection("users").doc(_currentUid).get();

    if (user.exists && user.data() != null) {
      return UserModel.fromMap(user.data()!);
    } else {
      throw const Failure("User profile is not found");
    }
  }

  @override
  Future<void> updateUserProfile(
      {required String name,
      required int avatar,
      required String phoneNumber}) async {
    final userRef = firestore.collection("users").doc(_currentUid);

    await userRef
        .update({"name": name, "avatar": avatar, "phoneNumber": phoneNumber});
  }

  @override
  Future<void> toggleWishlist(int movieId, bool isAdding) async {
    final userRef = firestore.collection("users").doc(_currentUid);

    if (isAdding) {
      await userRef.update({
        "wishList": FieldValue.arrayUnion([movieId.toString()])
      });
    } else {
      await userRef.update({
        "wishList": FieldValue.arrayRemove([movieId.toString()])
      });
    }
  }

  @override
  Future<void> addToHistory(int movieId) async {
    final userRef = firestore.collection("users").doc(_currentUid);

    await userRef.update({
      "history": FieldValue.arrayUnion([movieId.toString()])
    });
  }
}
