import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  Future<List<dynamic>> getProducts() async {
    final res = await _dio.get('/products');
    return res.data;
  }

  Future<Map<String, dynamic>> getUser(int id) async {
    final res = await _dio.get('/users/$id');
    return res.data;
  }
}
