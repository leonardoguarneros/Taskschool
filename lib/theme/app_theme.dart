import 'package:flutter/material.dart';

final ValueNotifier<ThemeMode> modoTema = ValueNotifier(ThemeMode.light);

class AppTheme {
  static const Color azulMarino = Color(0xFF0B2A6F);
  static const Color azul = Color(0xFF2B7BE4);
  static const Color azulClaro = Color(0xFFDCE8FA);

  static bool esOscuro(BuildContext c) =>
      Theme.of(c).brightness == Brightness.dark;

  static Color fondoTarjeta(BuildContext c) =>
      esOscuro(c) ? Color(0xFF1B2A4A) : Colors.white;

  static Color colorTitulo(BuildContext c) =>
      esOscuro(c) ? Color(0xFF8DB8FF) : azulMarino;

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

  static ThemeData get oscuro {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorSchemeSeed: azul,
      appBarTheme: AppBarTheme(
        backgroundColor: azulMarino,
        foregroundColor: Colors.white,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: Color(0xFF8DB8FF),
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}