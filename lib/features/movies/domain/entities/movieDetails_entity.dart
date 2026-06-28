import 'package:equatable/equatable.dart';
import 'package:movix/features/movies/domain/entities/cast_entity.dart';
import 'package:movix/features/movies/domain/entities/similarMovie_entity.dart';

class MovieDetailsEntity extends Equatable {
  final String title;
  final int year;
  final int likeCount;
  final int filmTime;
  final double rating;
  final List<String> screenshots;
  final String coverImage;
  final String summary;
  final String ytTrailerCode;
  final List<String> genres;
  final List<CastEntity> cast;
  final List<SimilarMoviesEntity> similarMovies;

  const MovieDetailsEntity(
      {required this.title,
      required this.year,
      required this.likeCount,
      required this.filmTime,
      required this.rating,
      required this.screenshots,
      required this.coverImage,
      required this.summary,
      required this.genres,
      required this.cast,
      required this.similarMovies,
        required this.ytTrailerCode});

  @override
  List<Object?> get props => [
        title,
        year,
        likeCount,
        filmTime,
        rating,
        screenshots,
        coverImage,
        summary,
        genres,
        cast,
        similarMovies,
     ytTrailerCode
      ];
}

