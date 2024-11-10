import 'package:flutter/material.dart';
import 'package:provider/provider.dart';  // Importez provider
import 'pages/welcome_page.dart';
import 'pages/login_page.dart';
 import 'pages/wave_page.dart';  
 import 'pages/register_page.dart';  
import 'providers/auth_provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthProvider(),  // Fournir AuthProvider
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Poppins',
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
      ),
      // Déterminez la route initiale en fonction de l'authentification
      initialRoute: _getInitialRoute(context),
      routes: {
      '/': (context) => WelcomePage(),
      '/login': (context) => LoginPage(),
      '/wave_services': (context) => WaveServices(),
      '/register': (context) => SignUpPage(),
    },

    );
  }

  // Fonction pour déterminer la route initiale en fonction de l'état de l'authentification
  String _getInitialRoute(BuildContext context) {
    // Si l'utilisateur est authentifié, redirigez vers la page des services, sinon vers la page d'accueil
    return Provider.of<AuthProvider>(context).isAuthenticated ? '/wave_services' : '/';
  }
}
