import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../transfert/contact_list_widgets.dart';
import '../../services/api_service.dart';
import '../../services/auth_service.dart'; // Importez AuthService

class TransfertPlanified extends StatefulWidget {
  @override
  _TransfertPlanifiedState createState() => _TransfertPlanifiedState();
}

class _TransfertPlanifiedState extends State<TransfertPlanified> {
  final _plannedDateController = TextEditingController();
  final _amountController = TextEditingController();
  final ApiService _apiService = ApiService();
  final Logger _logger = Logger();
  final AuthService _authService = AuthService(); // Instance d'AuthService
  List<Contact> _filteredContacts = [];
  List<String> _selectedReceiverPhones = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  Future<void> _fetchContacts() async {
    setState(() {
      _isLoading = true;
    });

    if (await FlutterContacts.requestPermission()) {
      final contacts = await FlutterContacts.getContacts(withProperties: true, withThumbnail: false);
      setState(() {
        _filteredContacts = contacts.where((contact) => contact.phones.isNotEmpty).toList();
        _isLoading = false;
      });
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      _plannedDateController.text = pickedDate.toString().split(' ')[0];
    }
  }

  void _toggleSelection(String phoneNumber) {
    setState(() {
      if (_selectedReceiverPhones.contains(phoneNumber)) {
        _selectedReceiverPhones.remove(phoneNumber);
      } else {
        _selectedReceiverPhones.add(phoneNumber);
      }
    });
  }

  bool _validateFields() {
    if (_plannedDateController.text.isEmpty ||
        _amountController.text.isEmpty ||
        _selectedReceiverPhones.isEmpty) {
      return false;
    }

    try {
      double.parse(_amountController.text);

      final plannedDate = DateTime.parse(_plannedDateController.text);
      if (plannedDate.isBefore(DateTime.now())) {
        return false;
      }
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> _scheduleTransfer() async {
    if (!_validateFields()) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez remplir tous les champs correctement et vérifier la date.')),
      );
      return;
    }

    // Récupérer le token et définir dans ApiService
    final token = await _authService.getToken();
    _logger.d(token);
    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur : Token manquant. Connectez-vous de nouveau.')),
      );
      return;
    }

    final plannedDate = _plannedDateController.text;
    final amount = double.parse(_amountController.text);

    final transferData = {
      'planified_date': plannedDate,
      'receiver_phones': _selectedReceiverPhones,
      'montant': amount,
    };
    _logger.d(transferData);
    try {
      final response = await _apiService.post('api/transfers/planified', transferData);
    _apiService.setToken(token);
    _logger.d(response['data']);
      if (response['success'] == true) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Transfert programmé avec succès')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur lors de la planification du transfert')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur réseau : ${error.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Planifier un transfert'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _plannedDateController,
              decoration: InputDecoration(
                hintText: 'Date prévue (YYYY-MM-DD)',
              ),
              readOnly: true,
              onTap: _selectDate,
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(
                hintText: 'Montant du transfert',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 32.0),
            _isLoading
                ? Center(child: CircularProgressIndicator())
                : ContactList(
                    filteredContacts: _filteredContacts,
                    selectedReceiverPhones: _selectedReceiverPhones,
                    isLoading: _isLoading,
                    fetchContacts: _fetchContacts,
                    toggleSelection: _toggleSelection,
                  ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _scheduleTransfer,
              child: Text('Planifier le transfert'),
            ),
          ],
        ),
      ),
    );
  }
}
