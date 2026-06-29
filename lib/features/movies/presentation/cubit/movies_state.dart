import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_details_entity.dart';

abstract class MoviesState extends Equatable {
  const MoviesState();

  @override
  List<Object?> get props => [];
}

class MoviesInitial extends MoviesState {}

class MovieDetailsLoading extends MoviesState {}

class MovieDetailsLoaded extends MoviesState {
  final MovieDetailsEntity movie;

  const MovieDetailsLoaded({required this.movie});

  @override
  List<Object?> get props => [movie];
}

class MovieDetailsError extends MoviesState {
  final String errorMessage;

  const MovieDetailsError({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
