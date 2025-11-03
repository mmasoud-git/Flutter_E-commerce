import 'package:get_it/get_it.dart';
import '../data/datasource/api_service.dart';
import '../data/repositories/product_repository_impl.dart';
import '../domain/repositories/product_repository.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<ApiService>(() => ApiService());
  sl.registerLazySingleton<ProductRepository>(
        () => ProductRepositoryImpl(apiService: sl()),
  );
}
