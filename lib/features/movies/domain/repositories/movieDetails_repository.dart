import 'package:movix/features/movies/domain/entities/movieDetails_entity.dart';

abstract class MoviedetailsRepository {
  Future<MovieDetailsEntity> getMovieDetails(int movieId);
}