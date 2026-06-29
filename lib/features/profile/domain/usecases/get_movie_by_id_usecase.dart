import 'package:movix/features/home/domain/entities/movie_entity.dart';
import 'package:movix/features/profile/domain/repositories/profile_repository.dart';

class GetMovieByIdUseCase {
  final ProfileRepository repository;

  GetMovieByIdUseCase(this.repository);

  Future<MovieEntity> execute(int id) async {
    return await repository.getMovieById(id);
  }
}
