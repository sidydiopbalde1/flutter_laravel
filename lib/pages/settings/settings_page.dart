import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'profile_widgets.dart';
import 'settings_items_widgets.dart';
import 'settings_section_widgets.dart';

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
        appBar: _buildAppBar(),
        body: ListView(
          children: [
            buildProfileSection(context),
            buildSection(
              title: 'Compte',
              items: [
                buildSettingsItem(
                  icon: FontAwesomeIcons.userGear,
                  title: 'Déplafonnement',
                  subtitle: 'Augmentez vos limites de transaction',
                  onTap: () => _showDeplatfonnementDialog(context),
                ),
                buildSettingsItem(
                  icon: FontAwesomeIcons.lock,
                  title: 'Sécurité',
                  subtitle: 'Code PIN, authentification biométrique',
                  onTap: () => _showSecurityOptions(context),
                ),
              ],
            ),
            buildSection(
              title: 'Préférences',
              items: [
                buildSettingsItem(
                  icon: FontAwesomeIcons.bell,
                  title: 'Notifications',
                  subtitle: 'Gérer les alertes et notifications',
                  onTap: () => _showNotificationSettings(context),
                ),
                buildSettingsItem(
                  icon: FontAwesomeIcons.language,
                  title: 'Langue',
                  subtitle: 'Français',
                  trailing: Icon(FontAwesomeIcons.chevronRight, size: 16),
                  onTap: () => _showLanguageSelection(context),
                ),
                buildSettingsItem(
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
            buildSection(
              title: 'Support',
              items: [
                buildSettingsItem(
                  icon: FontAwesomeIcons.circleInfo,
                  title: 'À propos',
                  subtitle: 'Version 1.0.0',
                  onTap: () => _showAboutDialog(context),
                ),
                buildSettingsItem(
                  icon: FontAwesomeIcons.headset,
                  title: 'Support client',
                  subtitle: 'Aide et assistance',
                  onTap: () => _showSupportOptions(context),
                ),
              ],
            ),
            buildSection(
              title: 'Compte',
              items: [
                buildSettingsItem(
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

PreferredSizeWidget _buildAppBar() {
  return AppBar(
    title: Text('Paramètres', style: TextStyle(fontWeight: FontWeight.w600)),
    backgroundColor: Colors.blue[600],
    elevation: 0,
  );
}

  void _showDeplatfonnementDialog(BuildContext context) {
    // Implémenter la logique de déplafonnement
  }

  void _showSecurityOptions(BuildContext context) {
    // Implémenter les options de sécurité
  }

  void _showNotificationSettings(BuildContext context) {
    // Implémenter les paramètres de notification
  }

  void _showLanguageSelection(BuildContext context) {
    // Implémenter la sélection de la langue
  }

  void _showAboutDialog(BuildContext context) {
    // Implémenter le dialogue à propos
  }

  void _showSupportOptions(BuildContext context) {
    // Implémenter le support client
  }

  void _showLogoutDialog(BuildContext context) {
    // Implémenter la déconnexion
  }
}
