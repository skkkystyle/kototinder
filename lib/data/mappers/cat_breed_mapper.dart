import '../../domain/entities/cat_breed.dart';
import '../models/cat_breed_model.dart';

class CatBreedMapper {
  static CatBreed toEntity(CatBreedModel model) {
    return CatBreed(
      id: model.id,
      name: model.name,
      description: model.description,
      temperament: model.temperament,
      origin: model.origin,
      lifeSpan: model.lifeSpan,
      wikipediaUrl: model.wikipediaUrl,
    );
  }
}