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
    if (state is! ProfileLoaded) {
      return;
    }
    final currentUser = (state as ProfileLoaded).user;

    try {
      await updateUserProfileUseCase.execute(
          name: newName, avatar: newAvatar, phoneNumber: phoneNumber);

      final updatedUser = currentUser.copyWith(
        name: newName,
        avatar: newAvatar,
        phoneNumber: phoneNumber,
      );

      emit(ProfileLoaded(updatedUser));
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

    final currentUser = (state as ProfileLoaded).user;
    final isInList = isInWishlist(movieId);

    final updatedWishList = List<String>.from(currentUser.wishList ?? []);

    if (isInList) {
      updatedWishList.remove(movieId.toString());
    } else {
      updatedWishList.add(movieId.toString());
    }

    final updatedUser = currentUser.copyWith(wishList: updatedWishList);
    emit(ProfileLoaded(updatedUser));

    try {
      await toggleWishlistUseCase.execute(
          movieId: movieId, isAdding: !isInList);
    } catch (e) {
      emit(ProfileLoaded(currentUser));
      emit(ProfileError(FirebaseErrorHandler.getReadableError(e)));
    }
  }

  Future<void> addMovieToHistory(int movieId) async {
    if (state is! ProfileLoaded) {
      return;
    }

    final currentUser = (state as ProfileLoaded).user;

    if (currentUser.history?.contains(movieId.toString()) ?? false) {
      return;
    }

    final updatedHistory = List<String>.from(currentUser.history ?? []);
    updatedHistory.add(movieId.toString());

    final updatedUser = currentUser.copyWith(history: updatedHistory);
    emit(ProfileLoaded(updatedUser));

    try {
      await addToHistoryUseCase.execute(movieId);
    } catch (e) {
      emit(ProfileLoaded(currentUser));
      emit(ProfileError(FirebaseErrorHandler.getReadableError(e)));
    }
  }
}
