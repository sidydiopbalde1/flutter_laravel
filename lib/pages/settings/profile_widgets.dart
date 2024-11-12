import 'package:flutter/material.dart';

Widget buildProfileSection(BuildContext context) {
  return Container(
    margin: EdgeInsets.all(16),
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blue[100],
          child: Text(
            'JD',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sidy Diop Balde',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'sididiop53@gmail.com',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: Icon(Icons.edit),
          onPressed: () => _showEditProfile(context),
        ),
      ],
    ),
  );
}

void _showEditProfile(BuildContext context) {
  // Implémenter l'édition du profil
}
