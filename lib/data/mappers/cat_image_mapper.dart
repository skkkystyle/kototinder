import '../../domain/entities/cat_image.dart';
import '../models/cat_image_model.dart';
import 'cat_breed_mapper.dart';

class CatImageMapper {
  static CatImage toEntity(CatImageModel model) {
    return CatImage(
      id: model.id,
      url: model.url,
      width: model.width,
      height: model.height,
      breed: model.breed != null ? CatBreedMapper.toEntity(model.breed!) : null,
    );
  }
}