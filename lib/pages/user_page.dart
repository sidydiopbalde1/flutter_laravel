// import 'package:flutter/material.dart';
// import '../services/api_service.dart';  // Assurez-vous que l'importation de ApiService est correcte

// class UsersPage extends StatefulWidget {
//   @override
//   _UsersPageState createState() => _UsersPageState();
// }

// class _UsersPageState extends State<UsersPage> {
//   late Future<List<User>> users;

//   @override
//   void initState() {
//     super.initState();
//     // Initialiser la récupération des utilisateurs
//     users = ApiService().getUsers();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Liste des utilisateurs'),
//       ),
//       body: FutureBuilder<List<User>>(
//         future: users,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             return Center(child: Text('Erreur : ${snapshot.error}'));
//           } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text('Aucun utilisateur trouvé.'));
//           } else {
//             List<User> usersList = snapshot.data!;
//             return ListView.builder(
//               itemCount: usersList.length,
//               itemBuilder: (context, index) {
//                 User user = usersList[index];
//                 return Card(
//                   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//                   child: ListTile(
//                     leading: CircleAvatar(
//                       backgroundImage: user.photo.isNotEmpty
//                           ? NetworkImage(user.photo)  // Si photo est une URL
//                           : AssetImage('assets/default_avatar.png') as ImageProvider, // Image par défaut si pas de photo
//                     ),
//                     title: Text('${user.nom} ${user.prenom}'),
//                     subtitle: Text(user.email),
//                     trailing: Column(
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text('Solde: ${user.solde}'),
//                         Text('Plafond: ${user.plafond ?? 'Non défini'}'),
//                       ],
//                     ),
//                     onTap: () {
//                       // Ajouter des actions lors de la sélection d'un utilisateur
//                       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                         content: Text('Utilisateur sélectionné : ${user.nom} ${user.prenom}'),
//                       ));
//                     },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
// }
