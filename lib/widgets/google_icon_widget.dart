// lib/widgets/google_icon_widget.dart

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GoogleIconWidget extends StatelessWidget {
  const GoogleIconWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: FaIcon(
        FontAwesomeIcons.google,
        color: Colors.red,
        size: 30.0,
      ),
      onPressed: () {
        // Ajouter l'action à effectuer lors du clic sur l'icône de Google
      },
    );
  }
}
