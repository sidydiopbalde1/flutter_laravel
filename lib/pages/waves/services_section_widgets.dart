import 'package:flutter/material.dart';
import 'services_card_widgets.dart';
import '../transfert/transfert_page.dart';

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
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: [
              ServiceCard(
                icon: Icons.send,
                title: 'Envoyer',
                 onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransferPage()),
                      ),
              ),
              ServiceCard(
                icon: Icons.money,
                title: 'Retirer',
                onTap: () {},
              ),
              ServiceCard(
                icon: Icons.credit_card,
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
