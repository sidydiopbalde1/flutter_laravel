import 'dart:convert';
import 'package:logger/logger.dart';
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final ApiService _apiService = ApiService();
  final Logger _logger = Logger();

  // Méthode de connexion
  Future<Map<String, dynamic>> login(String telephone, String password) async {
    _logger.d("Tentative de connexion avec le téléphone : $telephone");

    try {
      final response = await _apiService.post(
        'api/user/login',
        {
          'telephone': telephone,
          'password': password,
        },
      );

      // Vérifiez si la réponse contient le token et le stockez
      if (response.containsKey('token')) {
        String token = response['token'];
        await _storeToken(token);
        _apiService.setToken(token);
        _logger.i("Connexion réussie et token sauvegardé pour le téléphone : $telephone");
      } else {
        _logger.w("Le token n'a pas été trouvé dans la réponse.");
        throw Exception('Token manquant dans la réponse');
      }

      _logger.d("Données envoyées : ${json.encode({'telephone': telephone, 'password': password})}");
      return response;
    } catch (e) {
      _logger.e("Erreur lors de la connexion : $e");
      throw Exception('Erreur de connexion au serveur : $e');
    }
  }

  // Méthode d'inscription
  Future<Map<String, dynamic>> register({
    required String nom,
    required String prenom,
    required String telephone,
    required String email,
    required String password,
    String? photoUrl,
  }) async {
    _logger.d("Tentative d'inscription pour l'email : $email");

    try {
      final response = await _apiService.post(
        'api/user',
        {
          'nom': nom,
          'prenom': prenom,
          'telephone': telephone,
          'email': email,
          'password': password,
        },
      );

      _logger.i("Inscription réussie pour l'email : $email");
      _logger.d("Données envoyées : ${json.encode({
        'nom': nom,
        'prenom': prenom,
        'telephone': telephone,
        'email': email,
        'password': password,
      })}");
      return response;
    } catch (e) {
      _logger.e("Erreur lors de l'inscription : $e");
      throw Exception('Erreur d\'inscription au serveur : $e');
    }
  }

  // Méthode pour stocker le token dans SharedPreferences
  Future<void> _storeToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Méthode pour récupérer le token stocké
  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}
