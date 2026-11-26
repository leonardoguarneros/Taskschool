import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color azulMarino = Color(0xFF0B2A6F);
  static const Color azul = Color(0xFF2B7BE4);
  static const Color azulClaro = Color(0xFFDCE8FA);

  static ThemeData get tema {
    final base = ThemeData(useMaterial3: true, colorSchemeSeed: azul);

    return base.copyWith(
      scaffoldBackgroundColor: Colors.white,
      textTheme: GoogleFonts.poppinsTextTheme(base.textTheme),
      appBarTheme: AppBarTheme(
        backgroundColor: azulMarino,
        foregroundColor: Colors.white,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: azul,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
