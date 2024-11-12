import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeSection extends StatelessWidget {
  final String qrCodeData;

  const QRCodeSection({required this.qrCodeData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: QrImageView(
        data: qrCodeData,
        version: QrVersions.auto,
        size: 100.0,
      ),
    );
  }
}
