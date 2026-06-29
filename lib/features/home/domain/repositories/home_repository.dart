import '../entities/movie_entity.dart';

abstract class HomeRepository {
  Future<List<MovieEntity>> getMovies();
  Future<List<MovieEntity>> getActionMovies();
  Future<List<MovieEntity>> getNextPage({required int page});
  Future<MovieEntity> getMovieById(int id);
  Future<List<MovieEntity>> getMoviesByIds(List<int> ids);
}
