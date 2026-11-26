import 'package:flutter/material.dart';

class AppTheme {
  static const Color azulMarino = Color(0xFF0B2A6F);
  static const Color azul = Color(0xFF2B7BE4);
  static const Color azulClaro = Color(0xFFDCE8FA);

  static ThemeData get tema {
    return ThemeData(
      useMaterial3: true,
      colorSchemeSeed: azul,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: azulMarino,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: azul,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
