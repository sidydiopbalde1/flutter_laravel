import 'package:flutter/material.dart';
import 'widgets.dart'; // Importez le fichier widgets.dart

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                const WelcomeLogo(), // Widget extrait pour le logo
                const SizedBox(height: 40),
                const WelcomeTitle(), // Widget extrait pour le titre
                const SizedBox(height: 16),
                const WelcomeSubtitle(), // Widget extrait pour le sous-titre
                const SizedBox(height: 60),
                const StartButton(), // Widget extrait pour le bouton
                const SizedBox(height: 20),
                const LoginRedirectText(), // Widget extrait pour le texte de redirection
              ],
            ),
          ),
        ),
      ),
    );
  }
}
