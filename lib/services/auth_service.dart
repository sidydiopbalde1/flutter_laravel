import 'dart:convert';
import 'package:logger/logger.dart';
import 'api_service.dart'; // Assurez-vous d'importer votre ApiService

class AuthService {
  final ApiService _apiService = ApiService(); // Instance de ApiService
  final Logger _logger = Logger();

  // Méthode de connexion
  Future<Map<String, dynamic>> login(String telephone, String password) async {
    _logger.d("Tentative de connexion avec le téléphone : $telephone");

    try {
      final response = await _apiService.post(
        'api/user/login', // Endpoint pour la connexion
        {
          'telephone': telephone,
          'password': password,
        },
      );

      _logger.i("Connexion réussie pour le téléphone : $telephone");
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
        'api/user', // Endpoint pour l'inscription
        {
          'nom': nom,
          'prenom': prenom,
          'telephone': telephone,
          'email': email,
          'password': password,
          // 'photo': photoUrl,
        },
      );

      _logger.i("Inscription réussie pour l'email : $email");
      _logger.d("Données envoyées : ${json.encode({
        'nom': nom,
        'prenom': prenom,
        'telephone': telephone,
        'email': email,
        'password': password,
        // 'photo': photoUrl,
      })}");
      return response;
    } catch (e) {
      _logger.e("Erreur lors de l'inscription : $e");
      throw Exception('Erreur d\'inscription au serveur : $e');
    }
  }
}
