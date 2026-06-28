import 'package:movix/core/network/network_exceptions.dart';
import 'package:movix/features/movies/data/datasources/movieDetails_remote_data_source.dart';
import 'package:movix/features/movies/data/models/movieDetails_model.dart';
import 'package:movix/features/movies/domain/entities/movieDetails_entity.dart';
import 'package:movix/features/movies/domain/entities/similarMovie_entity.dart';
import 'package:movix/features/movies/domain/repositories/movieDetails_repository.dart';

class MovieDetailsRepositoryImpl implements MoviedetailsRepository {
  final MoviedetailsRemoteDataSource remoteDataSource;

  MovieDetailsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<MovieDetailsEntity> getMovieDetails(int movieId) async {
    try {
      // Execute both details and suggestions requests concurrently
      final results = await Future.wait([
        remoteDataSource.getMovieDetails(movieId),
        remoteDataSource.getSimilarMovies(movieId),
      ]);

      final movieJson = results[0] as Map<String, dynamic>;
      final similarMovies = results[1] as List<SimilarMoviesEntity>;

      return MoviedetailsModel.fromJson(movieJson, similarMovies);
    } catch (e) {
      throw Exception(NetworkExceptions.getErrorMessage(e));
    }
  }
}
