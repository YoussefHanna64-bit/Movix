import 'package:movix/features/movies/domain/entities/movie_details_entity.dart';
import 'package:movix/features/movies/domain/repositories/movie_details_repository.dart';

class GetMovieDetailsUseCase {
  final MovieDetailsRepository repository;

  GetMovieDetailsUseCase(this.repository);

  Future<MovieDetailsEntity> call(int movieId) async {
    return await repository.getMovieDetails(movieId);
  }
}
