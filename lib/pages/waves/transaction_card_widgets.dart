import 'package:flutter/material.dart';
import '../../models/transaction.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(Icons.payment, color: Colors.blue),
        title: Text(transaction.type),
        subtitle: Text('Montant: ${transaction.montant} €'),
        trailing: Text(transaction.date.toString()), // Correction ici
        onTap: () {},
      ),
    );
  }
}
