import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/movie_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<MovieModel>> getMovies();
  Future<List<MovieModel>> getActionMovies();
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final DioClient dioClient;

  HomeRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<List<MovieModel>> getMovies() async {
    final response = await dioClient.get(ApiConstants.listMovies);
    
    if (response.data != null && response.data['data'] != null && response.data['data']['movies'] != null) {
      final List moviesList = response.data['data']['movies'];
      return moviesList.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    return [];
  }

  @override
  Future<List<MovieModel>> getActionMovies() async {
    final response = await dioClient.get(
      ApiConstants.listMovies,
      queryParameters: {'genre': 'Action'},
    );

    if (response.data != null && response.data['data'] != null && response.data['data']['movies'] != null) {
      final List moviesList = response.data['data']['movies'];
      return moviesList.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    return [];
  }
}
