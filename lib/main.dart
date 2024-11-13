import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'pages/home/welcome_page.dart';
import 'pages/login/login_page.dart';
import 'pages/waves/wave_page.dart';
import 'pages/register/register_page.dart';
import 'providers/auth_provider.dart';
import 'theme/theme_provider.dart';
import 'providers/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialisez Hive
  await Hive.initFlutter();
  await Hive.openBox('authBox'); // Ouvrez la boîte pour stocker des données (authBox)

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Wave Money',
            debugShowCheckedModeBanner: false,
            theme: themeProvider.themeData,
            initialRoute: _getInitialRoute(context),
            routes: {
              '/': (context) => const WelcomePage(),
              '/login': (context) => const LoginPage(),
              '/wave_services': (context) => WaveServices(),
              '/register': (context) => const SignUpPage(),
            },
          );
        },
      ),
    );
  }

  String _getInitialRoute(BuildContext context) {
    return Provider.of<AuthProvider>(context, listen: false).isAuthenticated
        ? '/wave_services'
        : '/';
  }
}
