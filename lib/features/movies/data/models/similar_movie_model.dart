import 'package:movix/features/movies/domain/entities/similar_movie_entity.dart';

class SimilarMovieModel extends SimilarMoviesEntity{
  const SimilarMovieModel({required super.id, required super.rating, required super.coverImg});

  factory SimilarMovieModel.fromJson(Map<String, dynamic> json) {
    try {
      return SimilarMovieModel(
        id: json['id'] as int? ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        coverImg: json['medium_cover_image'] as String? ?? '',
      );
    } catch (e) {
      return const SimilarMovieModel(id: 0, rating: 0.0, coverImg: '');
    }
  }
}