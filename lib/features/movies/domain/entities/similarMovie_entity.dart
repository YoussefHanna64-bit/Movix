import 'package:equatable/equatable.dart';

class SimilarMoviesEntity extends Equatable{
  final int id;
  final double rating;
  final String coverImg;

  const SimilarMoviesEntity({required this.id, required this.rating, required this.coverImg});

  @override
  List<Object?> get props => [id, rating, coverImg];

}