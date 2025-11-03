import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasource/api_service.dart';


class ProductRepositoryImpl implements ProductRepository {
  final ApiService apiService;

  ProductRepositoryImpl({required this.apiService});

  @override
  Future<List<Product>> getProducts() async {
    final data = await apiService.getProducts();
    return data.map<Product>((e) => Product.fromJson(e)).toList();
  }
}
