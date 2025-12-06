// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_image.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatImage _$CatImageFromJson(Map<String, dynamic> json) => CatImage(
  id: json['id'] as String,
  url: json['url'] as String,
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  breeds:
      (json['breeds'] as List<dynamic>?)
          ?.map((e) => CatBreed.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);

Map<String, dynamic> _$CatImageToJson(CatImage instance) => <String, dynamic>{
  'id': instance.id,
  'url': instance.url,
  'width': instance.width,
  'height': instance.height,
  'breeds': instance.breeds,
};
