import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_contacts/flutter_contacts.dart';  // Assurez-vous de bien importer le package


class TransferPage extends StatefulWidget {
  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  List<Contact> _contacts = [];
  List<int> _selectedReceiverIds = [];
  final _amountController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }

  // Fonction pour récupérer la liste des contacts du téléphone
 // Fonction pour récupérer la liste des contacts du téléphone
Future<void> _fetchContacts() async {
  // Demander la permission d'accès aux contacts
  bool hasPermission = await FlutterContacts.requestPermission();

  if (hasPermission) {
    // Récupérer les contacts et les ajouter à la liste
    List<Contact> contacts = await FlutterContacts.getContacts(withThumbnail: false);  // Notez 'withThumbnail' au singulier
    setState(() {
      _contacts = contacts;
    });
  } else {
    // Gérer le cas où la permission est refusée
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Permission refusée pour accéder aux contacts.")),
    );
  }
}


  // Fonction pour effectuer le transfert
  Future<void> _performTransfer() async {
    if (_amountController.text.isEmpty || _selectedReceiverIds.isEmpty) return;

    setState(() => _isLoading = true);
    final senderId = 4; // Remplacer par l'ID réel de l'expéditeur
    final montant = int.parse(_amountController.text);

    // Simuler l'envoi de la requête de transfert
    await Future.delayed(Duration(seconds: 2));

    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Transfert réussi !")));
    _amountController.clear();
    _selectedReceiverIds.clear();
  }

  // Fonction pour afficher la liste des contacts
  Widget _buildContactList() {
    return ListView.builder(
      itemCount: _contacts.length,
      itemBuilder: (context, index) {
        final contact = _contacts[index];
        final contactName = contact.displayName ?? "Nom inconnu";
        final isSelected = _selectedReceiverIds.contains(index);

        return ListTile(
          title: Text(contactName),
          trailing: Icon(
            isSelected ? Icons.check_box : Icons.check_box_outline_blank,
            color: isSelected ? Colors.blueAccent : Colors.grey,
          ),
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedReceiverIds.remove(index);
              } else {
                _selectedReceiverIds.add(index);
              }
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transfert d'argent"),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Montant à transférer",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Entrez le montant",
                prefixIcon: Icon(FontAwesomeIcons.moneyBillWave, color: Colors.blueAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              "Sélectionnez les destinataires",
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: _contacts.isEmpty
                  ? Center(child: CircularProgressIndicator())
                  : _buildContactList(),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _performTransfer,
              icon: Icon(FontAwesomeIcons.paperPlane),
              label: Text(_isLoading ? "En cours..." : "Transférer"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 14.0),
                textStyle: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
