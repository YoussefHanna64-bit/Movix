import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(String name, String email, String password,
      String phoneNumber, int avatar);
  Future<void> logout();
  Future<void> forgetPassword(String email);
  Future<void> changePassword(String newPassword);
  Future<void> deleteAccount();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDataSourceImpl({
    required this.firebaseAuth,
    required this.firestore,
  });

  @override
  Future<UserModel> login(String email, String password) async {
    // 1. Authenticate with Firebase Auth
    final userCredential = await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    // 2. Fetch the user's extra data from Firestore
    final docSnapshot = await firestore.collection('users').doc(uid).get();

    if (docSnapshot.exists && docSnapshot.data() != null) {
      return UserModel.fromMap(docSnapshot.data()!);
    } else {
      throw Exception('User data not found in the database.');
    }
  }

  @override
  Future<UserModel> register(String name, String email, String password,
      String phoneNumber, int avatar) async {
    // 1. Create the user in Firebase Auth
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    final uid = userCredential.user!.uid;

    // 2. Create the UserModel with initial empty lists and default avatar
    final newUser = UserModel(
      uid: uid,
      name: name,
      email: email,
      avatar: avatar,
      phoneNumber: phoneNumber,
      wishList: [],
      history: [],
    );

    // 3. Save the extra data to Firestore under the 'users' collection
    await firestore.collection('users').doc(uid).set(newUser.toMap());

    return newUser;
  }

  @override
  Future<void> forgetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> changePassword(String newPassword) async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("No user is currently signed in");
    }

    await user.updatePassword(newPassword);
  }

  @override
  Future<void> deleteAccount() async {
    final user = firebaseAuth.currentUser;
    if (user == null) {
      throw Exception("No user is currently signed in.");
    }

    await firestore.collection("users").doc(user.uid).delete();

    await user.delete();
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}
