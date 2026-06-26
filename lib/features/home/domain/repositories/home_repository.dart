import '../entities/movie_entity.dart';

abstract class HomeRepository {
  Future<List<MovieEntity>> getMovies();
  Future<List<MovieEntity>> getActionMovies();
}
