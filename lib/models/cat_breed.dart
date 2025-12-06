import 'package:json_annotation/json_annotation.dart';

part 'cat_breed.g.dart';

@JsonSerializable()
class CatBreed {
  final String id;
  final String name;
  final String? description;
  final String? temperament;
  final String? origin;
  @JsonKey(name: 'life_span')
  final String? lifeSpan;
  @JsonKey(name: 'wikipedia_url')
  final String? wikipediaUrl;

  CatBreed({
    required this.id,
    required this.name,
    this.description,
    this.temperament,
    this.origin,
    this.lifeSpan,
    this.wikipediaUrl,
  });

  factory CatBreed.fromJson(Map<String, dynamic> json) =>
      _$CatBreedFromJson(json);

  Map<String, dynamic> toJson() => _$CatBreedToJson(this);
}
