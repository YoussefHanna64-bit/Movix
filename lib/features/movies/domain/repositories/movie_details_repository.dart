import 'package:movix/features/movies/domain/entities/movie_details_entity.dart';

abstract class MovieDetailsRepository {
  Future<MovieDetailsEntity> getMovieDetails(int movieId);
}