import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class FavoritesProvider extends ChangeNotifier {
  Set<String> _ids = {};

  FavoritesProvider() { load(); }

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(Constants.PREFS_FAVORITES);
    if (raw != null) {
      final list = List<String>.from(jsonDecode(raw));
      _ids = Set<String>.from(list);
    }
    notifyListeners();
  }

  Future<void> toggleFavorite(String productId) async {
    if (_ids.contains(productId)) {
      _ids.remove(productId);
    } else {
      _ids.add(productId);
    }
    await _save();
    notifyListeners();
  }

  bool isFav(String id) => _ids.contains(id);

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(Constants.PREFS_FAVORITES, jsonEncode(_ids.toList()));
  }

  List<String> get favoritesList => _ids.toList();
}