import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/cart_item.dart';

class CartProvider extends ChangeNotifier {
  final ApiService api = ApiService();
  List<CartItem> items = [];
  bool loading = false;

  Future<void> fetchCartForUser(String userId) async {
    loading = true; notifyListeners();
    final resp = await api.get('/cart');
    if (resp.statusCode == 200) {
      final list = List<Map<String, dynamic>>.from((resp.data as List).map((e) => Map<String, dynamic>.from(e)));
      final userItems = list.where((j) => j['userId'].toString() == userId).toList();
      items = userItems.map((j) => CartItem.fromJson(j)).toList();
    }
    loading = false; notifyListeners();
  }
}