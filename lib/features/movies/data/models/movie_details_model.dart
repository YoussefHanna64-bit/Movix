import 'package:movix/core/error/failure.dart';
import 'package:movix/features/movies/data/models/cast_model.dart';
import 'package:movix/features/movies/domain/entities/movie_details_entity.dart';
import 'package:movix/features/movies/domain/entities/similar_movie_entity.dart';

class MovieDetailsModel extends MovieDetailsEntity {
  const MovieDetailsModel({
    required super.title,
    required super.year,
    required super.likeCount,
    required super.filmTime,
    required super.rating,
    required super.screenshots,
    required super.coverImage,
    required super.summary,
    required super.genres,
    required super.cast,
    required super.similarMovies,
    required super.ytTrailerCode,
  });

  factory MovieDetailsModel.fromJson(
    Map<String, dynamic> json,
    List<SimilarMoviesEntity> similarMovies,
  ) {
    try {
      return MovieDetailsModel(
        title: json['title'] as String? ?? 'Unknown',
        year: json['year'] as int? ?? 0,
        likeCount: json['like_count'] as int? ?? 0,
        rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
        filmTime: json['runtime'] as int? ?? 0,
        coverImage: json['large_cover_image'] as String? ?? json['medium_cover_image'] as String? ?? '',
        genres: (json["genres"] as List<dynamic>?)
                ?.map((genre) => genre.toString())
                .toList() ??
            [],
        summary: json['description_full'] as String? ?? '',
        ytTrailerCode: json['yt_trailer_code'] as String? ?? '',
        screenshots: [
          json["medium_screenshot_image1"],
          json["medium_screenshot_image2"],
          json["medium_screenshot_image3"],
        ]
            .where((e) => e != null)
            .cast<String>()
            .toList(),
        cast: (json["cast"] as List<dynamic>?)
                ?.map((e) => CastModel.fromJson(e as Map<String, dynamic>))
                .toList() ??
            [],
        similarMovies: similarMovies,
      );
    } catch (e) {
      throw Failure("Failed to parse movie details: $e");
    }
  }
}

