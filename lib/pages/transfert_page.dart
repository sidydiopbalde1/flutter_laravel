import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import '../services/transaction_service.dart'; // Utilisation du service TransactionService

class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  List<String> _selectedReceiverPhones = [];
  final _amountController = TextEditingController();
  final _searchController = TextEditingController();
  bool _isLoading = false;

  final TransactionService _transactionService = TransactionService(); // Utilisation de TransactionService

  @override
  void initState() {
    super.initState();
    _fetchContacts();
    _searchController.addListener(_filterContacts);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _filterContacts() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredContacts = List.from(_contacts);
      } else {
        _filteredContacts = _contacts.where((contact) {
          final name = contact.displayName.toLowerCase();
          final phone = _getPhoneNumber(contact)?.toLowerCase() ?? '';
          return name.contains(query) || phone.contains(query);
        }).toList();
      }
    });
  }

  Future<void> _fetchContacts() async {
    setState(() => _isLoading = true);

    try {
      bool hasPermission = await FlutterContacts.requestPermission();

      if (hasPermission) {
        List<Contact> contacts = await FlutterContacts.getContacts(
          withProperties: true,
          withThumbnail: false,
        );

        contacts.sort((a, b) => a.displayName.compareTo(b.displayName));

        setState(() {
          _contacts = contacts;
          _filteredContacts = List.from(contacts);
          _isLoading = false;
        });
      } else {
        _showErrorSnackBar("Permission refusée pour accéder aux contacts.");
      }
    } catch (e) {
      _showErrorSnackBar("Erreur lors de la récupération des contacts: $e");
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        duration: Duration(seconds: 2),
      ),
    );
  }

  String? _getPhoneNumber(Contact contact) {
    if (contact.phones.isNotEmpty) {
      return contact.phones.first.number.replaceAll(RegExp(r'[^\d]'), '');
    }
    return null;
  }

  void _toggleSelection(String phoneNumber) {
    setState(() {
      if (_selectedReceiverPhones.contains(phoneNumber)) {
        _selectedReceiverPhones.remove(phoneNumber);
        print('Désélectionné: $phoneNumber');
      } else {
        _selectedReceiverPhones.add(phoneNumber);
        print('Sélectionné: $phoneNumber');
      }
    });
  }

  Future<void> _performTransfer() async {
    if (_amountController.text.isEmpty) {
      _showErrorSnackBar("Veuillez entrer un montant");
      return;
    }

    if (_selectedReceiverPhones.isEmpty) {
      _showErrorSnackBar("Veuillez sélectionner au moins un destinataire");
      return;
    }

    final amount = int.tryParse(_amountController.text);
    if (amount == null || amount <= 0) {
      _showErrorSnackBar("Veuillez entrer un montant valide");
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Appeler la méthode transferMoney du service TransactionService
      final response = await _transactionService.transferMoney(
        _selectedReceiverPhones,
        amount.toDouble(),
      );

      if (response['success'] == true) {
        _showSuccessSnackBar("Transfert réussi !");
        setState(() {
          _selectedReceiverPhones.clear();
          _amountController.clear();
        });
      } else {
        _showErrorSnackBar(response['message'] ?? "Échec du transfert");
      }
    } catch (e) {
      _showErrorSnackBar("Erreur lors du transfert : $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _buildSearchBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: "Rechercher par nom ou numéro...",
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          suffixIcon: _searchController.text.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: Colors.grey),
                  onPressed: () {
                    _searchController.clear();
                    FocusScope.of(context).unfocus();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _buildAmountInput() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Montant à transférer",
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              hintText: "Entrez le montant",
              prefixIcon: Icon(Icons.monetization_on),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_contacts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.contact_phone, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "Aucun contact disponible",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _fetchContacts,
              child: Text("Actualiser"),
            ),
          ],
        ),
      );
    }

    if (_filteredContacts.isEmpty && _searchController.text.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              "Aucun contact trouvé",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: _filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = _filteredContacts[index];
        final phoneNumber = _getPhoneNumber(contact);
        if (phoneNumber == null) return Container();

        final contactName = contact.displayName;
        final isSelected = _selectedReceiverPhones.contains(phoneNumber);
        final initials = contactName.isNotEmpty ? contactName[0].toUpperCase() : "?";

        return Card(
          elevation: 2,
          margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: isSelected ? Colors.blue : Colors.transparent,
              width: 1,
            ),
          ),
          child: ListTile(
            leading: CircleAvatar(
              child: Text(initials),
              backgroundColor: Colors.blue,
            ),
            title: Text(contactName),
            subtitle: Text(phoneNumber),
            trailing: isSelected
                ? Icon(Icons.check_circle, color: Colors.blue)
                : Icon(Icons.check_circle_outline, color: Colors.grey),
            onTap: () {
              _toggleSelection(phoneNumber);
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transfert d\'argent'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildSearchBar(),
            SizedBox(height: 16),
            _buildAmountInput(),
            SizedBox(height: 16),
            Expanded(child: _buildContactList()),
            ElevatedButton(
              onPressed: _performTransfer,
              child: Text('Effectuer le transfert'),
            ),
          ],
        ),
      ),
    );
  }
}
