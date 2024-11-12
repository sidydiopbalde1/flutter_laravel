import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import '../exceptions/auth_exception.dart';
class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  bool _isAuthenticated = false;
  String _token = '';
  String _message = '';
  final Logger _logger = Logger();

  bool get isAuthenticated => _isAuthenticated;
  String get token => _token;
  String get Message => _message;

  // Méthode de connexion
  Future<void> login(String telephone, String password) async {
    try {
      final response = await _authService.login(telephone, password);
      _token = response['token']; // Assurez-vous que la réponse contient un token

      _logger.d('Authentification réussie, token : $_token');
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      _logger.e('Erreur lors de la connexion : $e');
      throw Exception('Erreur lors de la connexion : $e');
    }
  }

  // Méthode d'inscription
Future<void> register({
    required String nom,
    required String prenom,
    required String telephone,
    required String email,
    required String password,
    // String? photoUrl,
}) async {
  try {
    // Log des données envoyées
    _logger.d("Tentative d'inscription avec les données : ${json.encode({
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'password': password,
      // 'photoUrl': photoUrl,
    })}");

    // Préparer les données à envoyer à l'API
    final data = {
      'nom': nom,
      'prenom': prenom,
      'telephone': telephone,
      'email': email,
      'password': password,
      // 'photoUrl': photoUrl,
    };

    // Appel à l'API pour effectuer l'inscription
    final response = await _authService.register(
      nom: nom,
      prenom: prenom,
      telephone: telephone,
      email: email,
      password: password,
      // photoUrl: photoUrl,
    );

    // Log de la réponse de l'API
    _logger.d("Réponse API : ${response.toString()}");

    // Vérification si l'inscription a été réussie
    // if (response['success'] == true) {
    //   // Inscription réussie
    //   _token = response['data']; // Assumer que la réponse contient un token ou des données utilisateur
    //   _message = response['message']; // Message de succès ou erreur
    //   _isAuthenticated = true;
    //   _logger.d('Inscription réussie, token : $_token');
    //   notifyListeners();
    // } else {
    //   // Si l'inscription échoue
    //   _logger.e("Erreur d'inscription : ${response['message'] ?? 'Erreur inconnue'}");
    //   throw AuthException("Erreur d'inscription : ${response['message'] ?? 'Erreur inconnue'}");
    // }
  } catch (e) {
    // Gestion des erreurs
    _logger.e('Erreur lors de l\'inscription : $e');
    rethrow;
  }
}


  // Méthode de déconnexion
  void logout() {
    _isAuthenticated = false;
    _token = '';
    _logger.d('Utilisateur déconnecté');
    notifyListeners();
  }
}
