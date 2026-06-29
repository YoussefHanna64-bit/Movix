import 'package:movix/features/home/domain/entities/movie_entity.dart';
import 'package:movix/features/home/domain/repositories/home_repository.dart';

class GetMovieByIdUseCase {
  final HomeRepository repository;

  GetMovieByIdUseCase(this.repository);

  Future<MovieEntity> execute(int id) async {
    return await repository.getMovieById(id);
  }
}
