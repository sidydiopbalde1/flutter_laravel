import 'package:flutter/material.dart';
import 'transaction_list_widget.dart';
import 'services_section_widgets.dart';
import 'header_widgets.dart';
import '/services/transaction_service.dart';
import '/models/transaction.dart';
import '../settings/settings_page.dart';

class WaveServices extends StatefulWidget {
  @override
  _WaveServicesState createState() => _WaveServicesState();
}

class _WaveServicesState extends State<WaveServices> {
  final String _qrCodeData = 'https://wavemobilemoney.com';
  final TransactionService _transactionService = TransactionService();

  Future<List<Transaction>> _transactionsFuture = Future.value([]);

  @override
  void initState() {
    super.initState();
    _transactionsFuture = _transactionService.getTransferHistory().catchError((e) {
      print("Erreur lors de la récupération des transactions : $e");
      return [];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Wave Services',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.blue[600],
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          HeaderSection(qrCodeData: _qrCodeData),
          ServicesSection(),
          TransactionListSection(transactionsFuture: _transactionsFuture),
        ],
      ),
    );
  }
}
