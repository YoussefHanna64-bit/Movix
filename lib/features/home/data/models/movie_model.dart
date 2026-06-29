import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.rating,
    required super.year,
    required super.backgroundImage,
    required super.coverImage,
    required super.mpaRating,
    required super.genres,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Unknown',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      year: json["year"] as int? ?? 0000,
      backgroundImage: json['background_image_original'] as String? ??
          json['background_image'] as String? ??
          '',
      coverImage: json['large_cover_image'] as String? ??
          json['medium_cover_image'] as String? ??
          '',
      mpaRating: json["mpa_rating"] as String? ?? "",
      genres: (json["genres"] as List<dynamic>?)
              ?.map((genre) => genre.toString())
              .toList() ??
          [],
    );
  }
}
