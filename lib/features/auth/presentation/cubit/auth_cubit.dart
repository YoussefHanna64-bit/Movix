import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/firebase_error_handler.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/forget_password_usecase.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  AuthFailure(this.error);
}

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;

  AuthCubit({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.forgetPasswordUseCase,
  }) : super(AuthInitial());

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
      emit(AuthFailure(FirebaseErrorHandler.getReadableError(e)));
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
      emit(AuthFailure(FirebaseErrorHandler.getReadableError(e)));
    }
  }

  // Logout method
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await logoutUseCase.execute();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(FirebaseErrorHandler.getReadableError(e)));
    }
  }

  // Forget Password method
  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await forgetPasswordUseCase.execute(email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(FirebaseErrorHandler.getReadableError(e)));
    }
  }
}
