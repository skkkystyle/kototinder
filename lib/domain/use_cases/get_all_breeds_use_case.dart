import '../entities/cat_breed.dart';
import '../repositories/cat_repository.dart';

class GetAllBreedsUseCase {
  final CatRepository repository;

  GetAllBreedsUseCase(this.repository);

  Future<List<CatBreed>> execute() async {
    return await repository.getAllBreeds();
  }
}