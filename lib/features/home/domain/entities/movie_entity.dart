import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final double rating;
  final int year;
  final String backgroundImage;
  final String coverImage;
  final String mpaRating;
  final List<String> genres;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.rating,
    required this.year,
    required this.backgroundImage,
    required this.coverImage,
    required this.mpaRating,
    required this.genres,
  });

  @override
  List<Object?> get props =>
      [id, title, rating, backgroundImage, coverImage, mpaRating, genres];
}
