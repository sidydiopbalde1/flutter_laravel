import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class ApiService {
  final String _baseUrl = 'http://192.168.6.216:8000'; // Remplacez cette URL par celle de votre backend
  final Logger _logger = Logger();

  // Méthode pour effectuer une requête POST
  Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        _logger.i("Requête POST réussie sur l'endpoint: $endpoint");
        return jsonDecode(response.body);
      } else {
        _logger.e("Échec de la requête POST sur l'endpoint: $endpoint");
        _logger.e("Code de statut: ${response.statusCode}");
        throw Exception('Erreur de requête POST');
      }
    } catch (e) {
      _logger.e("Erreur lors de la requête POST: $e");
      throw Exception('Erreur de connexion au serveur : $e');
    }
  }

  // Méthode pour effectuer une requête GET
  Future<Map<String, dynamic>> get(String endpoint) async {
    final url = Uri.parse('$_baseUrl/$endpoint');
    try {
      final response = await http.get(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        _logger.i("Requête GET réussie sur l'endpoint: $endpoint");
        return jsonDecode(response.body);
      } else {
        _logger.e("Échec de la requête GET sur l'endpoint: $endpoint");
        _logger.e("Code de statut: ${response.statusCode}");
        // _logger.e("Corps de la réponse: ${response.body}");
        throw Exception('Erreur de requête GET');
      }
    } catch (e) {
      _logger.e("Erreur lors de la requête GET: $e");
      throw Exception('Erreur de connexion au serveur : $e');
    }
  }


  //  Future<List<User>> getUsers() async {
  //   final response = await http.get(Uri.parse(baseUrl + 'users')); // Assurez-vous que l'endpoint 'users' est correct

  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse.map((user) => User.fromJson(user)).toList();
  //   } else {
  //     throw Exception('Échec du chargement des utilisateurs');
  //   }
  // }

   // Méthode pour effectuer un transfert
  // Future<Map<String, dynamic>> transferMoney(int senderId, int receiverId, double montant) async {
  //   // Paramètres à envoyer dans le corps de la requête
  //   final data = {
  //     "sender_id": senderId,
  //     "receiver_id": receiverId,
  //     "montant": montant,
  //   };

  //   // Appel de la méthode POST avec l'endpoint 'api/transaction/transfert/simple'
  //   return await post('api/transaction/transfert/simple', data);
  // }
}
