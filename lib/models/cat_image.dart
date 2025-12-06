import 'package:json_annotation/json_annotation.dart';
import 'cat_breed.dart';

part 'cat_image.g.dart';

@JsonSerializable()
class CatImage {
  final String id;
  final String url;
  final int width;
  final int height;
  @JsonKey(defaultValue: [])
  final List<CatBreed> breeds;

  CatImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    required this.breeds,
  });

  factory CatImage.fromJson(Map<String, dynamic> json) =>
      _$CatImageFromJson(json);
  Map<String, dynamic> toJson() => _$CatImageToJson(this);
  CatBreed? get breed => breeds.isNotEmpty ? breeds[0] : null;
}
