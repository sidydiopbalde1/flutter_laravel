import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class ContactList extends StatelessWidget {
  final List<Contact> filteredContacts;
  final List<String> selectedReceiverPhones;
  final bool isLoading;
  final Function fetchContacts;
  final Function toggleSelection;

  ContactList({
    required this.filteredContacts,
    required this.selectedReceiverPhones,
    required this.isLoading,
    required this.fetchContacts,
    required this.toggleSelection,
  });

  // Rendre la méthode accessible en la nommant getPhoneNumber
  String? getPhoneNumber(Contact contact) {
    if (contact.phones.isNotEmpty) {
      return contact.phones.first.number.replaceAll(RegExp(r'[^\d]'), '');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (filteredContacts.isEmpty) {
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
              onPressed: () => fetchContacts(),
              child: Text("Actualiser"),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: filteredContacts.length,
      itemBuilder: (context, index) {
        final contact = filteredContacts[index];
        final phoneNumber = getPhoneNumber(contact);
        if (phoneNumber == null) return Container();

        final contactName = contact.displayName;
        final isSelected = selectedReceiverPhones.contains(phoneNumber);
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
            onTap: () => toggleSelection(phoneNumber),
          ),
        );
      },
    );
  }
}
