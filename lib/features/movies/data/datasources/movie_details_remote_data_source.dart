import 'package:movix/core/error/failure.dart';
import 'package:movix/core/network/dio_client.dart';
import 'package:movix/features/movies/data/models/similar_movie_model.dart';
import 'package:movix/core/network/api_constants.dart';

abstract class MovieDetailsRemoteDataSource {
  Future<Map<String, dynamic>> getMovieDetails(int movieId);
  Future<List<SimilarMovieModel>> getSimilarMovies(int movieId);
}

class MovieDetailsRemoteDataSourceImpl implements MovieDetailsRemoteDataSource {
  final DioClient dioClient;

  MovieDetailsRemoteDataSourceImpl({required this.dioClient});

  @override
  Future<Map<String, dynamic>> getMovieDetails(int movieId) async {
    final response = await dioClient.get(ApiConstants.movieDetails, queryParameters: {
      'movie_id': movieId,
      'with_images': true,
      'with_cast': true,
    });

    if (response.data != null && response.data['data'] != null && response.data['data']['movie'] != null) {
      return response.data['data']['movie'] as Map<String, dynamic>;
    }
    throw const Failure("Movie details not found");
  }

  @override
  Future<List<SimilarMovieModel>> getSimilarMovies(int movieId) async {
    final response = await dioClient.get(ApiConstants.similarMovie, queryParameters: {
      'movie_id': movieId,
    });

    if (response.data != null && response.data['data'] != null && response.data['data']['movies'] != null) {
      final List moviesList = response.data['data']['movies'];
      return moviesList.map((movie) => SimilarMovieModel.fromJson(movie)).toList();
    }
    return [];
  }
}
