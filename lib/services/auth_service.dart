import 'dart:convert';
import 'package:logger/logger.dart';
import 'api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../exceptions/auth_exception.dart';

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

Future<Map<String, dynamic>> register({
  required String nom,
  required String prenom, 
  required String telephone,
  required String email,
  required String password,
}) async {
  try {
    _logger.d("Tentative d'inscription pour l'email : $email");

    // Préparer les données à envoyer
    final data = {
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'password': password,
    };

    // Envoyer la requête d'inscription à l'API
    final response = await _apiService.post('api/user', data);

    // Vérification de la réponse de l'API
    _logger.d("Réponse reçue : ${response.toString()}");  // Log de la réponse brute

    // Vérification de la présence des clés nécessaires dans la réponse
    if (response != null && response['success'] == true) {
      if (response['data'] != null) {
        // Inscription réussie, récupération des données de l'utilisateur
        _logger.i("Inscription réussie pour l'utilisateur ID : ${response['data']['id']}, email : $email");
        return response['data']; // Retourner les données de l'utilisateur
      } else {
        final message = response['message'] ?? 'Aucune donnée utilisateur renvoyée';
        _logger.e("Erreur d'inscription : $message");
        throw AuthException("Erreur d'inscription : $message");
      }
    } else {
      final message = response['message'] ?? 'Erreur inconnue';
      _logger.e("Inscription échouée : $message");
      throw AuthException("Erreur d'inscription : $message");
    }
  } catch (e) {
    _logger.e("Erreur lors de l'inscription : $e");
    rethrow;
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
