import 'package:movix/features/home/domain/entities/movie_entity.dart';
import 'package:movix/features/home/domain/repositories/home_repository.dart';

class GetNextPageUseCase {
  final HomeRepository repository;
  const GetNextPageUseCase({required this.repository});

  Future<List<MovieEntity>> call({required int page}) async {
    return await repository.getNextPage(page: page);
  }
}
