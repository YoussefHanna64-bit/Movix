import 'package:movix/features/auth/domain/entities/user_entity.dart';
import 'package:movix/features/home/domain/entities/movie_entity.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;
  final List<MovieEntity> wishlistMovies;
  final List<MovieEntity> historyMovies;

  ProfileLoaded(this.user,
      {this.wishlistMovies = const [], this.historyMovies = const []});
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);
}
