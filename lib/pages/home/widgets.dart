import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class WelcomeLogo extends StatelessWidget {
  const WelcomeLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      duration: const Duration(milliseconds: 1500),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // Rayon des coins
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2), // Couleur et opacité de l'ombre
              blurRadius: 10, // Flou de l'ombre
              offset: const Offset(0, 5), // Position de l'ombre
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20), // Assurez-vous que le rayon correspond
          child: Image.asset(
            'assets/images/welcome_image.png',
            height: 100,
            fit: BoxFit.cover, // Pour remplir correctement l'image dans son conteneur
          ),
        ),
      ),
    );
  }
}

class WelcomeTitle extends StatelessWidget {
  const WelcomeTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 200),
      duration: const Duration(milliseconds: 1500),
      child: const Text(
        'Bienvenue',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}

class WelcomeSubtitle extends StatelessWidget {
  const WelcomeSubtitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInDown(
      delay: const Duration(milliseconds: 400),
      duration: const Duration(milliseconds: 1500),
      child: const Text(
        'Découvrez une nouvelle façon de gérer votre argent',
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey,
          height: 1.5,
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 600),
      duration: const Duration(milliseconds: 1500),
      child: ElevatedButton(
        onPressed: () => Navigator.pushNamed(context, '/login'),
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(
            horizontal: 48,
            vertical: 16,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 0,
        ),
        child: const Text(
          'Commencer',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class LoginRedirectText extends StatelessWidget {
  const LoginRedirectText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeInUp(
      delay: const Duration(milliseconds: 800),
      duration: const Duration(milliseconds: 1500),
      child: TextButton(
        onPressed: () {},
        child: RichText(
          text: TextSpan(
            text: 'Déjà un compte ? ',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: 'Connexion',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
