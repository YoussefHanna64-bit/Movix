import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final int id;
  final String title;
  final double rating;
  final String backgroundImage;
  final String coverImage;

  const MovieEntity({
    required this.id,
    required this.title,
    required this.rating,
    required this.backgroundImage,
    required this.coverImage,
  });

  @override
  List<Object?> get props => [id, title, rating, backgroundImage, coverImage];
}
