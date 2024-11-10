import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _lightTheme = ThemeData.light();
  ThemeData _darkTheme = ThemeData.dark();

  ThemeData get themeData => _isDarkMode ? _darkTheme : _lightTheme;
  bool _isDarkMode = false;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  void setDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
