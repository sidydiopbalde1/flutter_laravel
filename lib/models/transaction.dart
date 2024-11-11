// transaction.dart
class Transaction {
  final int id;
  final double montant;
  final String status;
  final DateTime date;
  final double frais;
  final String type;
  final int senderId;
  final int receiverId;

  Transaction({
    required this.id,
    required this.montant,
    required this.status,
    required this.date,
    required this.frais,
    required this.type,
    required this.senderId,
    required this.receiverId,
  });

  // Factory method to create a Transaction from JSON
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      montant: double.parse(json['montant']),
      status: json['status'],
      date: DateTime.parse(json['date']),
      frais: double.parse(json['frais']),
      type: json['type'],
      senderId: json['sender_id'],
      receiverId: json['receiver_id'],
    );
  }
}
