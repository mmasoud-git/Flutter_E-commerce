import 'dart:convert';
import 'package:dio/dio.dart' as dio;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../services/api_service.dart';
import '../models/user.dart';

class AuthService {
  final ApiService api = ApiService();

  Future<User?> login(String username, String password) async {
    final resp = await api.post(
      '/auth/login',
      {'username': username, 'password': password},
      options: dio.Options(
        // <-- qualify with dio
        headers: {'Content-Type': 'application/json'},
      ),
    );

    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final body = resp.data;
      final token = body['token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(Constants.PREFS_TOKEN, token);
      return User(id: '1', name: username, email: '$username@demo.com');
    }
    throw Exception('Login failed: ${resp.statusCode}');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(Constants.PREFS_TOKEN);
    await prefs.remove(Constants.PREFS_USER);
  }

  Future<User?> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final userStr = prefs.getString(Constants.PREFS_USER);
    if (userStr == null) return null;
    final userJson = jsonDecode(userStr) as Map<String, dynamic>;
    return User.fromJson(userJson);
  }
}
