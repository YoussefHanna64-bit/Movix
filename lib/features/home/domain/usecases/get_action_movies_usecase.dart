import '../entities/movie_entity.dart';
import '../repositories/home_repository.dart';

class GetActionMoviesUseCase {
  final HomeRepository repository;

  GetActionMoviesUseCase(this.repository);

  Future<List<MovieEntity>> call() async {
    return await repository.getActionMovies();
  }
}
