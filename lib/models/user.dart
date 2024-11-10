// lib/models/user.dart

class User {
  final int id;
  final String nom;
  final String prenom;
  final String email;
  final String telephone;
  final String solde;
  final String photo;
  final String? plafond;
  final int roleId;
  final String createdAt;
  final String updatedAt;

  User({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.telephone,
    required this.solde,
    required this.photo,
    this.plafond,
    required this.roleId,
    required this.createdAt,
    required this.updatedAt,
  });

  // Méthode pour créer un utilisateur à partir d'un JSON
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      telephone: json['telephone'],
      solde: json['solde'],
      photo: json['photo'],  // Peut être une URL pour l'image ou le chemin local
      plafond: json['plafond'],
      roleId: json['role_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}
