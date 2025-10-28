import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service = AuthService();
  User? user;
  bool isLoading = false;

  Future<void> tryAutoLogin() async {
    isLoading = true; notifyListeners();
    user = await _service.tryAutoLogin();
    isLoading = false; notifyListeners();
  }

  Future<bool> login(String email, String password) async {
    isLoading = true; notifyListeners();
    final u = await _service.login(email, password);
    isLoading = false;
    if (u != null) {
      user = u; notifyListeners(); return true;
    }
    return false;
  }

  Future<void> logout() async {
    await _service.logout();
    user = null;
    notifyListeners();
  }
}