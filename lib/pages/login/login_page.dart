import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../providers/auth_provider.dart';
import '../register/register_page.dart';
import 'login_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      FadeInDown(
                        duration: const Duration(milliseconds: 1500),
                        child: const Text(
                          'Connexion',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FadeInDown(
                        delay: const Duration(milliseconds: 200),
                        duration: const Duration(milliseconds: 1500),
                        child: const Text(
                          'Connectez-vous pour accéder à votre compte',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeInDown(
                        delay: const Duration(milliseconds: 400),
                        duration: const Duration(milliseconds: 1500),
                        child: customTextField(
                          controller: _emailController,
                          labelText: 'Téléphone',
                          hintText: 'Entrez votre téléphone',
                          prefixIcon: Icons.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre téléphone';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadeInDown(
                        delay: const Duration(milliseconds: 600),
                        duration: const Duration(milliseconds: 1500),
                        child: customTextField(
                          controller: _passwordController,
                          labelText: 'Mot de passe',
                          hintText: 'Entrez votre mot de passe',
                          prefixIcon: Icons.lock_outline,
                          suffixIcon: _isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          onSuffixPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          obscureText: !_isPasswordVisible,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer votre mot de passe';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 12),
                      FadeInDown(
                        delay: const Duration(milliseconds: 800),
                        duration: const Duration(milliseconds: 1500),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      FadeInUp(
                        delay: const Duration(milliseconds: 1000),
                        duration: const Duration(milliseconds: 1500),
                        child: customButton('Se connecter', _onLoginPressed, context),
                      ),
                      const SizedBox(height: 20),
                      FadeInUp(
                        delay: const Duration(milliseconds: 1200),
                        duration: const Duration(milliseconds: 1500),
                        child: Center(
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpPage()),
                              );
                            },
                            child: const Text(
                              'Créer un compte',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInUp(
                        delay: const Duration(milliseconds: 1200),
                        duration: const Duration(milliseconds: 1500),
                        child: Row(
                          children: const [
                            Expanded(child: Divider()),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'Ou continuer avec',
                                style: TextStyle(color: Colors.grey),
                              ),
                            ),
                            Expanded(child: Divider()),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                      FadeInUp(
                        delay: const Duration(milliseconds: 1400),
                        duration: const Duration(milliseconds: 1500),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            socialButton(
                              FontAwesomeIcons.google,
                              'Google',
                              () {},
                            ),
                            socialButton(
                              FontAwesomeIcons.apple,
                              'Apple',
                              () {},
                            ),
                            socialButton(
                              FontAwesomeIcons.facebook,
                              'Facebook',
                              () {},
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _onLoginPressed() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      final telephone = _emailController.text;
      final password = _passwordController.text;
      try {
        await Provider.of<AuthProvider>(context, listen: false)
            .login(telephone, password);
        Navigator.pushReplacementNamed(context, '/wave_services');
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        // Afficher un message d'erreur
      }
    }
  }
}
