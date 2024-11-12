import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api_service.dart';
import '../services/auth_service.dart';

class UserProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();
  User? _user;

  User? get user => _user;

  Future<void> fetchUserData() async {
    const url = 'api/connected-users';

    try {
      // Get token from AuthService
      String? token = await _authService.getToken();

      if (token == null) {
        throw Exception('User is not authenticated');
      }

      // Call the `get` method of `ApiService` with the token
      final responseData = await _apiService.get(url);

      // Since `responseData` is a Map, directly use it to check for success
      if (responseData['success']) {
        _user = User.fromJson(responseData['data']);
        notifyListeners();  // Notify widgets that user data is loaded
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      rethrow;
    }
  }
}
