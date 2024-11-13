import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../transfert/transfert_page.dart';
import '../transfert_planified/transfert_planified_page.dart';
import 'services_card_widgets.dart';  // Assurez-vous d'importer le bon fichier contenant ServiceCard

class ServicesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Services',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 16),
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),  // Ne permet pas de défiler le GridView
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              ServiceCard(
                icon: Icons.send,  // Icône d'envoi
                title: 'Envoyer',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransferPage()),  // Navigation vers la page de transfert
                ),
              ),
              ServiceCard(
                icon: Icons.schedule,  // Icône de planification
                title: 'Planifier Transfert',
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransfertPlanified()),  // Navigue vers la même page pour planifier
                ),
              ),
              ServiceCard(
                icon: Icons.money,  // Icône de retrait
                title: 'Retirer',
                onTap: () {},
              ),
              ServiceCard(
                icon: Icons.credit_card,  // Icône de crédit
                title: 'Crédit',
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}
