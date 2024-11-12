import 'package:flutter/material.dart';
import '../../models/transaction.dart';
import 'transaction_card_widgets.dart';

class TransactionListSection extends StatelessWidget {
  final Future<List<Transaction>> transactionsFuture;

  const TransactionListSection({required this.transactionsFuture});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(top: 24),
        padding: EdgeInsets.only(top: 24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Transactions récentes',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder<List<Transaction>>(
                future: transactionsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Erreur de chargement des transactions'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('Aucune transaction disponible'));
                  } else {
                    return ListView.builder(
                      padding: EdgeInsets.all(16),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final transaction = snapshot.data![index];
                        return TransactionCard(transaction: transaction);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
