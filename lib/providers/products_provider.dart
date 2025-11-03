import 'package:flutter/material.dart';
import '../models/product.dart';
import '../services/api_service.dart';

class ProductsProvider extends ChangeNotifier {
  final ApiService api = ApiService();
  List<Product> _all = [];
  List<Product> filtered = [];
  bool loading = false;

  Future<void> fetchProducts() async {
    loading = true; notifyListeners();
    final resp = await api.get('/products');
    if (resp.statusCode == 200) {
      final list = List<Map<String, dynamic>>.from((resp.data as List).map((e) => Map<String, dynamic>.from(e)));
      _all = list.map((e) => Product.fromJson(e)).toList();
      filtered = List<Product>.from(_all);
    }
    loading = false; notifyListeners();
  }

  void search(String q) {
    if (q.trim().isEmpty) {
      filtered = List<Product>.from(_all);
    } else {
      final lower = q.toLowerCase();
      filtered = _all.where((p) =>
        p.title.toLowerCase().contains(lower) ||
        p.description.toLowerCase().contains(lower)
      ).toList();
    }
    notifyListeners();
  }

  List<Product> get all => _all;
}