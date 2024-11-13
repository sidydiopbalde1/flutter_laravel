import 'package:hive/hive.dart';
import '../models/user.dart';
import 'api_service.dart';
import 'auth_service.dart';

class UserService {
  final ApiService _apiService = ApiService();
  final AuthService _authService = AuthService();

  // Méthode pour récupérer les données de l'utilisateur connecté
  Future<User?> fetchUserData() async {
    const url = 'api/connected-users';

    // Vérification si les données utilisateur sont déjà stockées localement (Hive)
    var cachedUser = await _getCachedUserData();
    if (cachedUser != null) {
      return cachedUser;
    }

    // Récupération du token pour l'authentification
    String? token = await _authService.getToken();
    if (token == null) {
      throw Exception('User is not authenticated');
    }

    _apiService.setToken(token);

    try {
      final responseData = await _apiService.get(url);

      if (responseData['success']) {
        // Création de l'utilisateur à partir des données API et mise en cache
        User user = User.fromJson(responseData['data']);
        await _cacheUserData(user);
        return user;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (error) {
      throw Exception('Erreur lors de la récupération des données utilisateur: $error');
    }
  }

  // Méthode pour mettre en cache les données de l'utilisateur
  Future<void> _cacheUserData(User user) async {
    var box = await Hive.openBox('userBox');
    await box.put('user_data', user.toJson());
  }

  // Méthode pour récupérer les données mises en cache
  Future<User?> _getCachedUserData() async {
    var box = await Hive.openBox('userBox');
    var cachedData = box.get('user_data');
    if (cachedData != null) {
      return User.fromJson(cachedData);
    }
    return null;
  }
}
