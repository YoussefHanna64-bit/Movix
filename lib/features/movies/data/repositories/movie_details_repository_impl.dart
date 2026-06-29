import 'package:movix/core/error/failure.dart';
import 'package:movix/core/network/network_exceptions.dart';
import 'package:movix/features/movies/data/datasources/movie_details_remote_data_source.dart';
import 'package:movix/features/movies/data/models/movie_details_model.dart';
import 'package:movix/features/movies/domain/entities/movie_details_entity.dart';
import 'package:movix/features/movies/domain/entities/similar_movie_entity.dart';
import 'package:movix/features/movies/domain/repositories/movie_details_repository.dart';

class MovieDetailsRepositoryImpl implements MovieDetailsRepository {
  final MovieDetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieDetailsEntity> getMovieDetails(int movieId) async {
    try {
      final results = await Future.wait([
        remoteDataSource.getMovieDetails(movieId),
        remoteDataSource.getSimilarMovies(movieId),
      ]);

      final movieJson = results[0] as Map<String, dynamic>;
      final similarMovies = results[1] as List<SimilarMoviesEntity>;

      return MovieDetailsModel.fromJson(movieJson, similarMovies);
    } catch (e) {
      throw Failure(NetworkExceptions.getErrorMessage(e));
    }
  }
}
