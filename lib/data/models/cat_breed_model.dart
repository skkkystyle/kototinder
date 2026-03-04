import 'package:json_annotation/json_annotation.dart';

part 'cat_breed_model.g.dart';

@JsonSerializable()
class CatBreedModel {
  final String id;
  final String name;
  final String? description;
  final String? temperament;
  final String? origin;
  @JsonKey(name: 'life_span')
  final String? lifeSpan;
  @JsonKey(name: 'wikipedia_url')
  final String? wikipediaUrl;

  CatBreedModel({
    required this.id,
    required this.name,
    this.description,
    this.temperament,
    this.origin,
    this.lifeSpan,
    this.wikipediaUrl,
  });

  factory CatBreedModel.fromJson(Map<String, dynamic> json) =>
      _$CatBreedModelFromJson(json);

  Map<String, dynamic> toJson() => _$CatBreedModelToJson(this);
}
