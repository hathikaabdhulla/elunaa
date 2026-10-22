

import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

  // Signup
  Future<String> signUp({
    required String username,
    required String password,
  }) async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.setString("username", username);
    await prefs.setString("password", password);

    return "Account Created Successfully";
  }

  // Login
  Future<bool> login({
    required String username,
    required String password,
  }) async {

    final prefs = await SharedPreferences.getInstance();

    String? savedUsername = prefs.getString("username");
    String? savedPassword = prefs.getString("password");

    if (username == savedUsername &&
        password == savedPassword) {
      return true;
    }

    return false;
  }

  // Logout
  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove("username");
    await prefs.remove("password");
  }

  // Get Username
  Future<String?> getUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString("username");
  }
}