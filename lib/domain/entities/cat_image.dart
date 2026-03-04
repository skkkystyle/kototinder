import 'cat_breed.dart';

class CatImage {
  final String id;
  final String url;
  final int width;
  final int height;
  final CatBreed? breed;

  const CatImage({
    required this.id,
    required this.url,
    required this.width,
    required this.height,
    this.breed,
  });
}