import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

import '../../data/datasources/cat_api_data_source.dart';
import '../../data/repositories/cat_repository_impl.dart';
import '../../domain/repositories/cat_repository.dart';
import '../../domain/use_cases/get_all_breeds_use_case.dart';
import '../../domain/use_cases/get_random_cat_use_case.dart';
import '../analytics/analytics_service.dart';
import '../auth/auth_repository.dart';
import '../auth/auth_repository_impl.dart';
import '../auth/auth_service.dart';

final GetIt getIt = GetIt.instance;

Future<void> init() async {
  await dotenv.load(fileName: "assets/.env");

  // Data Layer
  getIt.registerLazySingleton<CatApiDataSource>(() => CatApiDataSource());

  // Repository
  getIt.registerLazySingleton<CatRepository>(
        () => CatRepositoryImpl(getIt()),
  );

  // Use Cases
  getIt.registerLazySingleton<GetRandomCatUseCase>(
        () => GetRandomCatUseCase(getIt()),
  );

  getIt.registerLazySingleton<GetAllBreedsUseCase>(
        () => GetAllBreedsUseCase(getIt()),
  );

  getIt.registerLazySingleton<AuthRepository>(() => SecureStorageAuthRepository());
  getIt.registerLazySingleton<AuthService>(() => AuthService(getIt()));
  getIt.registerLazySingleton<AnalyticsService>(() => AnalyticsService());
}