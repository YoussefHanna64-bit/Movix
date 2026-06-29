import 'package:movix/core/error/failure.dart';
import '../../../../core/network/network_exceptions.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;
  final Map<int, MovieEntity> _movieCache = {};

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MovieEntity>> getMovies() async {
    try {
      final movies = await remoteDataSource.getMovies();
      for (final movie in movies) {
        _movieCache[movie.id] = movie;
      }
      return movies;
    } catch (e) {
      throw Failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  @override
  Future<List<MovieEntity>> getActionMovies() async {
    try {
      final movies = await remoteDataSource.getActionMovies();
      for (final movie in movies) {
        _movieCache[movie.id] = movie;
      }
      return movies;
    } catch (e) {
      throw Failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  @override
  Future<List<MovieEntity>> getNextPage({required int page}) async {
    try {
      final movies = await remoteDataSource.getNextPage(page: page);
      for (final movie in movies) {
        _movieCache[movie.id] = movie;
      }
      return movies;
    } catch (e) {
      throw Failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  @override
  Future<MovieEntity> getMovieById(int id) async {
    if (_movieCache.containsKey(id)) {
      return _movieCache[id]!;
    }
    try {
      final movie = await remoteDataSource.getMovieById(id);
      _movieCache[id] = movie;
      return movie;
    } catch (e) {
      throw Failure(NetworkExceptions.getErrorMessage(e));
    }
  }

  @override
  Future<List<MovieEntity>> getMoviesByIds(List<int> ids) async {
    final List<MovieEntity> movies = [];
    final List<int> missingIds = [];

    for (var id in ids) {
      if (_movieCache.containsKey(id)) {
        movies.add(_movieCache[id]!);
      } else {
        missingIds.add(id);
      }
    }

    if (missingIds.isNotEmpty) {
      try {
        final fetchedMovies = await remoteDataSource.getMoviesByIds(missingIds);
        for (var movie in fetchedMovies) {
          _movieCache[movie.id] = movie;
          movies.add(movie);
        }
      } catch (e) {
        throw Failure(NetworkExceptions.getErrorMessage(e));
      }
    }

    return movies;
  }
}
