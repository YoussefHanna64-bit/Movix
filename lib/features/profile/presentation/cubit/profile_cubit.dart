import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/firebase_error_handler.dart';
import 'package:movix/features/profile/domain/usecases/add_to_history_usecase.dart';
import 'package:movix/features/profile/domain/usecases/get_user_profile_usecase.dart';
import 'package:movix/features/profile/domain/usecases/toggle_wishlist_usecase.dart';
import 'package:movix/features/profile/domain/usecases/update_user_profile_usecase.dart';
import 'package:movix/features/profile/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetUserProfileUseCase getUserProfileUseCase;
  final UpdateUserProfileUseCase updateUserProfileUseCase;
  final ToggleWishlistUseCase toggleWishlistUseCase;
  final AddToHistoryUseCase addToHistoryUseCase;

  ProfileCubit({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
    required this.toggleWishlistUseCase,
    required this.addToHistoryUseCase,
  }) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final user = await getUserProfileUseCase.execute();
      emit(ProfileLoaded(user));
    } catch (e) {
      emit(ProfileError(FirebaseErrorHandler.getReadableError(e)));
    }
  }

  Future<void> updateProfile(
      {required String newName,
      required int newAvatar,
      required String phoneNumber}) async {
    try {
      await updateUserProfileUseCase.execute(
          name: newName, avatar: newAvatar, phoneNumber: phoneNumber);

      await loadProfile();
    } catch (e) {
      emit(ProfileError(FirebaseErrorHandler.getReadableError(e)));
    }
  }

  bool isInWishlist(int movieId) {
    if (state is ProfileLoaded) {
      final user = (state as ProfileLoaded).user;
      return user.wishList?.contains(movieId.toString()) ?? false;
    }
    return false;
  }

  Future<void> toggleWishlist(int movieId) async {
    if (state is! ProfileLoaded) {
      return;
    }

    final isInList = isInWishlist(movieId);

    try {
      await toggleWishlistUseCase.execute(
          movieId: movieId, isAdding: !isInList);

      await loadProfile();
    } catch (e) {
      emit(ProfileError(FirebaseErrorHandler.getReadableError(e)));
    }
  }

  Future<void> addMovieToHistory(int movieId) async {
    if (state is! ProfileLoaded) {
      return;
    }

    final user = (state as ProfileLoaded).user;
    if (user.history?.contains(movieId.toString()) ?? false) {
      return;
    }

    try {
      await addToHistoryUseCase.execute(movieId);
      await loadProfile();
    } catch (e) {
      emit(ProfileError(FirebaseErrorHandler.getReadableError(e)));
    }
  }
}
