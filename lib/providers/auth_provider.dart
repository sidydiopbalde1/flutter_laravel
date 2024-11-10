import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
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
      final response = await _authService.register(
        nom: nom,
        prenom: prenom,
        telephone: telephone,
        email: email,
        password: password,
        // photoUrl: photoUrl,
      );

      _token = response['user'];
      _message= response['message'];
      _isAuthenticated = true;
      _logger.d(' $_message');
      _logger.d('Inscription réussie, token : $_token');
      notifyListeners();
    } catch (e) {
       _logger.d("Données envoyées : ${json.encode({
        'nom': nom,
        'prenom': prenom,
        'telephone': telephone,
        'email': email,
        'password': password,
        // 'photo': photoUrl,
      })}");
      _logger.e('Erreur lors de l\'inscription : $e');
      throw Exception('Erreur lors de l\'inscription : $e');
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
