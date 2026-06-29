import 'package:movix/features/home/domain/entities/movie_entity.dart';
import 'package:movix/features/home/domain/repositories/home_repository.dart';

class GetMoviesByIdsUseCase {
  final HomeRepository repository;

  GetMoviesByIdsUseCase(this.repository);

  Future<List<MovieEntity>> execute(List<int> ids) async {
    return await repository.getMoviesByIds(ids);
  }
}
