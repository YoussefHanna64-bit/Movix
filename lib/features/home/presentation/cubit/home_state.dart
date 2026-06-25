import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<MovieEntity> movies;
  final List<MovieEntity> actionMovies;

  const HomeLoaded({
    required this.movies,
    required this.actionMovies,
  });

  @override
  List<Object> get props => [movies, actionMovies];
}

class HomeError extends HomeState {
  final String errorMessage;

  const HomeError({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
