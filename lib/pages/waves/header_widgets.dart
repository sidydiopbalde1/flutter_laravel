import 'package:flutter/material.dart';
import 'qr_code_widgets.dart';
import 'balance_widgets.dart';

class HeaderSection extends StatelessWidget {
  final String qrCodeData;

  const HeaderSection({required this.qrCodeData});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[600],
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                QRCodeSection(qrCodeData: qrCodeData),
                SizedBox(width: 20),
                BalanceSection(), //widgets pour afficher la balance
              ],
            ),
          ),
          Container(
            height: 24,
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
          ),
        ],
      ),
    );
  }
}
