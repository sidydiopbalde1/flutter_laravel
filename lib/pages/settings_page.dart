import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkMode = false; // Le thème par défaut est clair

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: Text('Paramètres', style: TextStyle(fontWeight: FontWeight.w600)),
          backgroundColor: Colors.blue[600],
          elevation: 0,
        ),
        body: ListView(
          children: [
            _buildProfileSection(context),
            _buildSection(
              title: 'Compte',
              items: [
                SettingsItem(
                  icon: FontAwesomeIcons.userGear,
                  title: 'Déplafonnement',
                  subtitle: 'Augmentez vos limites de transaction',
                  onTap: () {
                    _showDeplatfonnementDialog(context);
                  },
                ),
                SettingsItem(
                  icon: FontAwesomeIcons.lock,
                  title: 'Sécurité',
                  subtitle: 'Code PIN, authentification biométrique',
                  onTap: () {
                    _showSecurityOptions(context);
                  },
                ),
              ],
            ),
            _buildSection(
              title: 'Préférences',
              items: [
                SettingsItem(
                  icon: FontAwesomeIcons.bell,
                  title: 'Notifications',
                  subtitle: 'Gérer les alertes et notifications',
                  onTap: () {
                    _showNotificationSettings(context);
                  },
                ),
                SettingsItem(
                  icon: FontAwesomeIcons.language,
                  title: 'Langue',
                  subtitle: 'Français',
                  trailing: Icon(FontAwesomeIcons.chevronRight, size: 16),
                  onTap: () {
                    _showLanguageSelection(context);
                  },
                ),
                SettingsItem(
                  icon: FontAwesomeIcons.palette,
                  title: 'Thème',
                  subtitle: _isDarkMode ? 'Sombre' : 'Clair',
                  trailing: Switch(
                    value: _isDarkMode,
                    onChanged: (value) {
                      setState(() {
                        _isDarkMode = value;
                      });
                    },
                  ),
                  onTap: () {},
                ),
              ],
            ),
            _buildSection(
              title: 'Support',
              items: [
                SettingsItem(
                  icon: FontAwesomeIcons.circleInfo,
                  title: 'À propos',
                  subtitle: 'Version 1.0.0',
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
                SettingsItem(
                  icon: FontAwesomeIcons.headset,
                  title: 'Support client',
                  subtitle: 'Aide et assistance',
                  onTap: () {
                    _showSupportOptions(context);
                  },
                ),
              ],
            ),
            _buildSection(
              title: 'Compte',
              items: [
                SettingsItem(
                  icon: FontAwesomeIcons.rightFromBracket,
                  title: 'Déconnexion',
                  subtitle: 'Se déconnecter de l\'application',
                  onTap: () => _showLogoutDialog(context),
                  color: Colors.red,
                ),
              ],
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
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
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.blue[100],
            child: Text(
              'JD',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'John Doe',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'john.doe@example.com',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: Icon(FontAwesomeIcons.penToSquare),
            onPressed: () => _showEditProfile(context),
          ),
        ],
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> items,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue[800],
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
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
          child: Column(children: items),
        ),
      ],
    );
  }

  void _showDeplatfonnementDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Déplafonnement'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Limites actuelles :'),
            SizedBox(height: 8),
            _buildLimitItem('Envoi quotidien', '500 €'),
            _buildLimitItem('Retrait quotidien', '1000 €'),
            SizedBox(height: 16),
            Text('Pour augmenter vos limites, veuillez fournir des documents supplémentaires.'),
          ],
        ),
        actions: [
          TextButton(
            child: Text('Plus tard'),
            onPressed: () => Navigator.pop(context),
          ),
          ElevatedButton(
            child: Text('Commencer'),
            onPressed: () {
              // Implémenter le processus de déplafonnement
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLimitItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _showSecurityOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(FontAwesomeIcons.fingerprint),
              title: Text('Empreinte digitale'),
              trailing: Switch(value: true, onChanged: (value) {}),
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.lock),
              title: Text('Changer le code PIN'),
              onTap: () {
                // Implémenter le changement de PIN
              },
            ),
            ListTile(
              leading: Icon(FontAwesomeIcons.shield),
              title: Text('Validation en deux étapes'),
              trailing: Switch(value: false, onChanged: (value) {}),
            ),
          ],
        ),
      ),
    );
  }

  void _showNotificationSettings(BuildContext context) {
    // Implémenter les paramètres de notification
  }

  void _showLanguageSelection(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: Text('Français'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text('Anglais'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              title: Text('Espagnol'),
              onTap: () => Navigator.pop(context),
            ),
          ],
        ),
      ),
    );
  }

  void _showEditProfile(BuildContext context) {
    // Implémenter la modification du profil
  }

  void _showAboutDialog(BuildContext context) {
    // Implémenter la vue "À propos"
  }

  void _showSupportOptions(BuildContext context) {
    // Implémenter les options de support
  }

  void _showLogoutDialog(BuildContext context) {
    // Implémenter le processus de déconnexion
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final Widget? trailing;
  final Color? color;

  SettingsItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.trailing,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(subtitle),
      trailing: trailing,
      onTap: onTap,
    );
  }
}
