import '../entities/cat_breed.dart';
import '../entities/cat_image.dart';

abstract class CatRepository {
  Future<CatImage> getRandomCat();
  Future<List<CatBreed>> getAllBreeds();
  Future<CatBreed> getBreedById(String breedId);
}