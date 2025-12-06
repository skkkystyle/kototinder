// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_breed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatBreed _$CatBreedFromJson(Map<String, dynamic> json) => CatBreed(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String?,
  temperament: json['temperament'] as String?,
  origin: json['origin'] as String?,
  lifeSpan: json['life_span'] as String?,
  wikipediaUrl: json['wikipedia_url'] as String?,
);

Map<String, dynamic> _$CatBreedToJson(CatBreed instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'temperament': instance.temperament,
  'origin': instance.origin,
  'life_span': instance.lifeSpan,
  'wikipedia_url': instance.wikipediaUrl,
};
