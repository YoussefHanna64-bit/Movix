import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/features/auth/domain/usecases/change_password_usecase.dart';
import 'package:movix/features/auth/domain/usecases/delete_account_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/forget_password_usecase.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String error;

  const AuthFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class AuthCubit extends Cubit<AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final ForgetPasswordUseCase forgetPasswordUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;

  AuthCubit({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.forgetPasswordUseCase,
    required this.changePasswordUseCase,
    required this.deleteAccountUseCase,
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
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
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
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> changePassword({required String newPassword}) async {
    emit(AuthLoading());
    try {
      await changePasswordUseCase.execute(newPassword);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  Future<void> deleteAccount() async {
    emit(AuthLoading());
    try {
      await deleteAccountUseCase.execute();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Logout method
  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await logoutUseCase.execute();
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }

  // Forget Password method
  Future<void> forgetPassword({required String email}) async {
    emit(AuthLoading());
    try {
      await forgetPasswordUseCase.execute(email);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString().replaceAll('Exception: ', '')));
    }
  }
}
