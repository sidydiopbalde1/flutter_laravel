import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'transfert_page.dart'; // Importez votre TransferPage

class WaveServices extends StatefulWidget {
  @override
  _WaveServicesState createState() => _WaveServicesState();
}

class _WaveServicesState extends State<WaveServices> {
  final String _qrCodeData = 'https://wavemobilemoney.com';

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Wave Services'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scan the QR code to access Wave services',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            // Center(
            //   child: QrImage(
            //     data: _qrCodeData,
            //     version: QrVersions.auto,
            //     size: 200.0,
            //   ),
            // ),
            const SizedBox(height: 32.0),
            const Text(
              'Available Wave Services',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: GridView.count(
                crossAxisCount: 3,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _ServiceCard(
                    icon: FontAwesomeIcons.dollarSign,
                    title: 'Send Money',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => TransferPage()),
                      );
                    },
                  ),
                  _ServiceCard(
                    icon: FontAwesomeIcons.arrowsAltV,
                    title: 'Withdraw',
                    onTap: () {
                      _launchUrl('https://wavemobilemoney.com/withdraw');
                    },
                  ),
                  _ServiceCard(
                    icon: FontAwesomeIcons.moneyBillAlt,
                    title: 'Buy Airtime',
                    onTap: () {
                      _launchUrl('https://wavemobilemoney.com/buy-airtime');
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ServiceCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: const BoxDecoration(
              color: Colors.blueAccent,
              shape: BoxShape.circle,
            ),
            child: FaIcon(
              icon,
              color: Colors.white,
              size: 32.0,
            ),
          ),
          const SizedBox(height: 8.0),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
