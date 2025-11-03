import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/usecases/get_products.dart';
import '../../njection/dependency_injection.dart';


final productProvider = FutureProvider<List<Product>>((ref) async {
  final usecase = GetProducts(sl());
  return await usecase();
});
