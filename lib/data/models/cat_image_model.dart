import 'package:json_annotation/json_annotation.dart';
import 'cat_breed_model.dart';

part 'cat_image_model.g.dart';

@JsonSerializable()
class CatImageModel {
  final String id;
  final String url;
  final int width;
  final int height;
  @JsonKey(defaultValue: [])
  final List<CatBreedModel> breeds;

  CatImageModel({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    required this.breeds,
  });

  factory CatImageModel.fromJson(Map<String, dynamic> json) =>
      _$CatImageModelFromJson(json);
  Map<String, dynamic> toJson() => _$CatImageModelToJson(this);
  CatBreedModel? get breed => breeds.isNotEmpty ? breeds[0] : null;
}
