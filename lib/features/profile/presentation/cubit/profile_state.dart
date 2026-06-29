import 'package:equatable/equatable.dart';
import 'package:movix/features/auth/domain/entities/user_entity.dart';
import 'package:movix/features/home/domain/entities/movie_entity.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final UserEntity user;
  final List<MovieEntity> wishlistMovies;
  final List<MovieEntity> historyMovies;

  const ProfileLoaded(this.user,
      {this.wishlistMovies = const [], this.historyMovies = const []});

  @override
  List<Object?> get props => [user, wishlistMovies, historyMovies];
}

class ProfileError extends ProfileState {
  final String message;

  const ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
