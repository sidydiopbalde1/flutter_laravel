import 'api_service.dart';
import 'package:logger/logger.dart';
import '../models/transaction.dart';  // Assurez-vous que le modèle Transaction est correctement importé
import 'package:shared_preferences/shared_preferences.dart';

class TransactionService {
  final ApiService _apiService = ApiService();
  final Logger _logger = Logger();

  // Méthode pour récupérer le token depuis SharedPreferences
  Future<void> _setToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('auth_token');
    if (token != null) {
      _apiService.setToken(token);
    } else {
      _logger.e("Aucun token trouvé, utilisateur non authentifié.");
      throw Exception('Utilisateur non authentifié');
    }
  }

  // Méthode pour récupérer l'historique des transactions de l'utilisateur connecté
  Future<List<Transaction>> getTransferHistory() async {
    _logger.d("Récupération de l'historique des transactions");

    try {
      await _setToken(); // Définir le token

      final response = await _apiService.get('api/transaction/transfert/historique');

      if (response['success'] == true) {
        _logger.i("Historique des transactions récupéré avec succès.");
        return List<Transaction>.from(
          response['transactions'].map((json) => Transaction.fromJson(json))
        );
      } else {
        _logger.w("Échec lors de la récupération des transactions.");
        throw Exception('Échec lors de la récupération des transactions');
      }
    } catch (e) {
      _logger.e("Erreur lors de la récupération des transactions : $e");
      throw Exception('Erreur de récupération des transactions : $e');
    }
  }

  // Méthode pour effectuer un transfert d'argent
  Future<Map<String, dynamic>> transferMoney(List<String> telephones, double montant) async {
    _logger.d("Début du transfert d'argent");

    final data = {
      "telephones": telephones,
      "montant": montant,
    };

    try {
      await _setToken(); // Définir le token

      final response = await _apiService.post('api/transaction/transfert/multiple', data);

      if (response['success'] == true) {
        _logger.i("Transfert réussi.");
        return response;
      } else {
        _logger.w("Échec du transfert.");
        throw Exception('Échec lors du transfert');
      }
    } catch (e) {
      _logger.e("Erreur lors du transfert : $e");
      throw Exception('Erreur de transfert : $e');
    }
  }
}
