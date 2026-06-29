import 'package:movix/features/movies/domain/entities/cast_entity.dart';

class CastModel extends CastEntity{
  const CastModel({required super.castImage, required super.castName, required super.castCharacter});
  factory CastModel.fromJson(Map<String, dynamic> json){
    return CastModel(
      castImage: json['url_small_image'] ?? '',
      castName: json['name'] ?? '',
      castCharacter: json['character_name'] ?? '',
    );
  }


}