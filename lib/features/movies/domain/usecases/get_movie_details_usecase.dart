import 'package:movix/features/movies/domain/entities/movieDetails_entity.dart';
import 'package:movix/features/movies/domain/repositories/movieDetails_repository.dart';

class GetMovieDetailsUseCase {
  final MoviedetailsRepository repository;

  GetMovieDetailsUseCase(this.repository);

  Future<MovieDetailsEntity> call(int movieId) async {
    return await repository.getMovieDetails(movieId);
  }
}
