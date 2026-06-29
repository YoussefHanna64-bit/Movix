import 'package:movix/core/error/failure.dart';
import '../../../../core/network/api_constants.dart';
import '../../../../core/network/dio_client.dart';
import '../models/movie_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<MovieModel>> getMovies();
  Future<List<MovieModel>> getActionMovies();
  Future<List<MovieModel>> getNextPage({required int page});
  Future<MovieModel> getMovieById(int id);
  Future<List<MovieModel>> getMoviesByIds(List<int> ids);
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

  @override
  Future<List<MovieModel>> getNextPage({required int page}) async {
    final response = await dioClient.get(
      ApiConstants.listMovies,
      queryParameters: {"page": page},
    );

    if (response.data != null &&
        response.data["data"] != null &&
        response.data["data"]["movies"] != null) {
      final List movies = response.data["data"]["movies"];
      return movies.map((movie) => MovieModel.fromJson(movie)).toList();
    }
    return [];
  }

  @override
  Future<MovieModel> getMovieById(int id) async {
    final response = await dioClient
        .get(ApiConstants.movieDetails, queryParameters: {'movie_id': id});

    if (response.data != null &&
        response.data["data"] != null &&
        response.data["data"]["movie"] != null) {
      return MovieModel.fromJson(response.data["data"]["movie"]);
    }
    throw const Failure("Movie not found");
  }

  @override
  Future<List<MovieModel>> getMoviesByIds(List<int> ids) async {
    final results = await Future.wait<MovieModel?>(
      ids.map((id) async {
        try {
          return await getMovieById(id);
        } catch (e) {
          print('Failed to fetch movie $id: $e');
          return null;
        }
      }),
    );
    return results.whereType<MovieModel>().toList();
  }
}
