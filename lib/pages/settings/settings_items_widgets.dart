import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Widget buildSettingsItem({
  required IconData icon,
  required String title,
  required String subtitle,
  required VoidCallback onTap,
  Widget? trailing,
  Color color = Colors.black,
}) {
  return ListTile(
    leading: Icon(icon, color: color),
    title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
    subtitle: Text(subtitle),
    trailing: trailing,
    onTap: onTap,
  );
}
