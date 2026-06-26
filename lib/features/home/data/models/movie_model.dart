import '../../domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity {
  const MovieModel({
    required super.id,
    required super.title,
    required super.rating,
    required super.backgroundImage,
    required super.coverImage,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? 'Unknown',
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      backgroundImage: json['background_image_original'] as String? ?? json['background_image'] as String? ?? '',
      coverImage: json['large_cover_image'] as String? ?? json['medium_cover_image'] as String? ?? '',
    );
  }
}
