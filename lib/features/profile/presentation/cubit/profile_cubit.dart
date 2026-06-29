import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movix/core/utils/firebase_error_handler.dart';
import 'package:movix/features/profile/domain/usecases/get_movie_by_id_usecase.dart';
import 'package:movix/features/profile/domain/usecases/get_movies_by_ids_usecase.dart';
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
  final GetMovieByIdUseCase getMovieByIdUseCase;
  final GetMoviesByIdsUseCase getMoviesByIdsUseCase;

  ProfileCubit({
    required this.getUserProfileUseCase,
    required this.updateUserProfileUseCase,
    required this.toggleWishlistUseCase,
    required this.addToHistoryUseCase,
    required this.getMovieByIdUseCase,
    required this.getMoviesByIdsUseCase,
  }) : super(ProfileInitial());

  Future<void> loadProfile() async {
    emit(ProfileLoading());
    try {
      final user = await getUserProfileUseCase.execute();

      final wishlistIds =
          (user.wishList ?? []).map(int.tryParse).whereType<int>().toList();
      final historyIds =
          (user.history ?? []).map(int.tryParse).whereType<int>().toList();

      final results = await Future.wait([
        getMoviesByIdsUseCase.execute(wishlistIds),
        getMoviesByIdsUseCase.execute(historyIds),
      ]);

      emit(ProfileLoaded(
        user,
        wishlistMovies: results[0],
        historyMovies: results[1],
      ));
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

    final currentState = state as ProfileLoaded;
    final currentUser = currentState.user;

    try {
      await updateUserProfileUseCase.execute(
          name: newName, avatar: newAvatar, phoneNumber: phoneNumber);

      final updatedUser = currentUser.copyWith(
        name: newName,
        avatar: newAvatar,
        phoneNumber: phoneNumber,
      );

      emit(ProfileLoaded(
        updatedUser,
        wishlistMovies: currentState.wishlistMovies,
        historyMovies: currentState.historyMovies,
      ));
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

    final currentState = state as ProfileLoaded;
    final currentUser = currentState.user;
    final isInList = isInWishlist(movieId);
    final updatedWishList = List<String>.from(currentUser.wishList ?? []);

    if (isInList) {
      updatedWishList.remove(movieId.toString());
      final updatedMovies = currentState.wishlistMovies.where((m) => m.id != movieId).toList();

      final updatedUser = currentUser.copyWith(wishList: updatedWishList);
      emit(ProfileLoaded(updatedUser,
          wishlistMovies: updatedMovies,
          historyMovies: currentState.historyMovies));
    } else {
      updatedWishList.add(movieId.toString());

      final updatedUser = currentUser.copyWith(wishList: updatedWishList);
      emit(ProfileLoaded(updatedUser,
          wishlistMovies: currentState.wishlistMovies,
          historyMovies: currentState.historyMovies));
      try {
        final movie = await getMovieByIdUseCase.execute(movieId);
        final updatedMovies = [...currentState.wishlistMovies, movie];
        emit(ProfileLoaded(updatedUser,
            wishlistMovies: updatedMovies,
            historyMovies: currentState.historyMovies));
      } catch (e) {
        print('Failed to fetch movie $movieId for wishlist: $e');
      }
    }

    try {
      await toggleWishlistUseCase.execute(
          movieId: movieId, isAdding: !isInList);
    } catch (e) {
      emit(ProfileLoaded(currentUser,
          wishlistMovies: currentState.wishlistMovies,
          historyMovies: currentState.historyMovies));
      emit(ProfileError(FirebaseErrorHandler.getReadableError(e)));
    }
  }

  Future<void> addMovieToHistory(int movieId) async {
    if (state is! ProfileLoaded) {
      return;
    }

    final currentState = state as ProfileLoaded;
    final currentUser = currentState.user;

    if (currentUser.history?.contains(movieId.toString()) ?? false) {
      return;
    }

    final updatedHistory = List<String>.from(currentUser.history ?? []);
    updatedHistory.add(movieId.toString());

    final updatedUser = currentUser.copyWith(history: updatedHistory);
    emit(ProfileLoaded(updatedUser,
        wishlistMovies: currentState.wishlistMovies,
        historyMovies: currentState.historyMovies));

    try {
      final movie = await getMovieByIdUseCase.execute(movieId);
      final updatedMovies = [...currentState.historyMovies, movie];
      emit(ProfileLoaded(updatedUser,
          wishlistMovies: currentState.wishlistMovies,
          historyMovies: updatedMovies));
    } catch (e) {
      print('Failed to fetch movie $movieId for history: $e');
    }

    try {
      await addToHistoryUseCase.execute(movieId);
    } catch (e) {
      emit(ProfileLoaded(currentUser,
          wishlistMovies: currentState.wishlistMovies,
          historyMovies: currentState.historyMovies));
      emit(ProfileError(FirebaseErrorHandler.getReadableError(e)));
    }
  }
}
