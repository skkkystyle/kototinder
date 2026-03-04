import '../../domain/entities/cat_breed.dart';
import '../../domain/entities/cat_image.dart';
import '../../domain/repositories/cat_repository.dart';
import '../datasources/cat_api_data_source.dart';
import '../mappers/cat_breed_mapper.dart';
import '../mappers/cat_image_mapper.dart';

class CatRepositoryImpl implements CatRepository {
  final CatApiDataSource dataSource;

  CatRepositoryImpl(this.dataSource);

  @override
  Future<CatImage> getRandomCat() async {
    final model = await dataSource.getRandomCat();
    return CatImageMapper.toEntity(model);
  }

  @override
  Future<List<CatBreed>> getAllBreeds() async {
    final models = await dataSource.getAllBreeds();
    return models.map(CatBreedMapper.toEntity).toList();
  }

  @override
  Future<CatBreed> getBreedById(String breedId) async {
    final model = await dataSource.getBreedById(breedId);
    return CatBreedMapper.toEntity(model);
  }
}