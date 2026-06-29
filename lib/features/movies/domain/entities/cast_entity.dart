import 'package:equatable/equatable.dart';

class CastEntity extends Equatable {
  final String castImage;
  final String castName;
  final String castCharacter;

  const CastEntity(
      {required this.castImage,
      required this.castName,
      required this.castCharacter});

  @override
  List<Object?> get props => [castImage, castName, castCharacter];
}
