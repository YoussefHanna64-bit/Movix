import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/forget_password_usecase.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/datasources/auth_remote_data_source.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  // Create instances of the use cases
  final RegisterUseCase registerUseCase = RegisterUseCase(AuthRepositoryImpl(
      AuthRemoteDataSourceImpl(
          firebaseAuth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance)));
  final LoginUseCase loginUseCase = LoginUseCase(AuthRepositoryImpl(
      AuthRemoteDataSourceImpl(
          firebaseAuth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance)));
  final LogoutUseCase logoutUseCase = LogoutUseCase(AuthRepositoryImpl(
      AuthRemoteDataSourceImpl(
          firebaseAuth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance)));
  final ForgetPasswordUseCase forgetPasswordUseCase = ForgetPasswordUseCase(
      AuthRepositoryImpl(AuthRemoteDataSourceImpl(
          firebaseAuth: FirebaseAuth.instance,
          firestore: FirebaseFirestore.instance)));

  // Converts Firebase exceptions into user-friendly messages
  String _getReadableError(dynamic e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'invalid-credential':
          return 'Invalid email or password. Please try again.';
        case 'email-already-in-use':
          return 'This email is already registered. Try logging in.';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'This account has been disabled. Contact support.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'network-request-failed':
          return 'No internet connection. Please check your network.';
        case 'operation-not-allowed':
          return 'This sign-in method is not enabled.';
        default:
          return e.message ?? 'An unexpected error occurred.';
      }
    }
    String message = e.toString();
    // Strip "Exception: " prefix and Firebase error code patterns
    if (message.startsWith('Exception: ')) {
      message = message.substring(11);
    }
    // Handle wrapped Firebase errors like "[firebase_auth/error-code] message"
    final firebaseRegex = RegExp(r'\[firebase_auth/([^\]]+)\]\s*(.*)');
    final match = firebaseRegex.firstMatch(message);
    if (match != null) {
      final code = match.group(1)!;
      switch (code) {
        case 'user-not-found':
          return 'No account found with this email.';
        case 'wrong-password':
          return 'Incorrect password. Please try again.';
        case 'invalid-credential':
          return 'Invalid email or password. Please try again.';
        case 'email-already-in-use':
          return 'This email is already registered. Try logging in.';
        case 'weak-password':
          return 'Password is too weak. Use at least 6 characters.';
        case 'invalid-email':
          return 'The email address is not valid.';
        case 'user-disabled':
          return 'This account has been disabled. Contact support.';
        case 'too-many-requests':
          return 'Too many attempts. Please try again later.';
        case 'network-request-failed':
          return 'No internet connection. Please check your network.';
        default:
          return match.group(2)?.isNotEmpty == true
              ? match.group(2)!
              : 'An unexpected error occurred.';
      }
    }
    return message.isNotEmpty ? message : 'An unexpected error occurred.';
  }

  // Register method
  Future<void> register({
    required String name,
    required String email,
    required String password,
    required String phoneNumber,
    required int avatar,
  }) async {
    emit(AuthLoading());
    try {
      await registerUseCase.execute(
        name: name,
        email: email,
        password: password,
        phoneNumber: phoneNumber,
        avatar: avatar,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(_getReadableError(e)));
    }
  }

  // Login method
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoading());
    try {
      await loginUseCase.execute(
        email: email,
        password: password,
      );
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(_getReadableError(e)));
    }
  }

  // Logout method
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await logoutUseCase.execute();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(_getReadableError(e)));
    }
  }

  // Forget Password method
  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await forgetPasswordUseCase.execute(email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(_getReadableError(e)));
    }
  }
}
