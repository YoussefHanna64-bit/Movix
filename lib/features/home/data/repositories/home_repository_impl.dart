import '../../../../core/network/network_exceptions.dart';
import '../../domain/entities/movie_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasource/home_remote_data_source.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<MovieEntity>> getMovies() async {
    try {
      return await remoteDataSource.getMovies();
    } catch (e) {
      throw Exception(NetworkExceptions.getErrorMessage(e));
    }
  }

  @override
  Future<List<MovieEntity>> getActionMovies() async {
    try {
      return await remoteDataSource.getActionMovies();
    } catch (e) {
      throw Exception(NetworkExceptions.getErrorMessage(e));
    }
  }

  @override
  Future<List<MovieEntity>> getNextPage({required int page}) async {
    try {
      return await remoteDataSource.getNextPage(page: page);
    } catch (e) {
      throw Exception(NetworkExceptions.getErrorMessage(e));
    }
  }
}
