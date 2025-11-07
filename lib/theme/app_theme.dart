import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryGreen = Color(0xFFA6CB1A);
  static const Color accentGreen = Color(0xFF7BB60B);
  static const Color darkText = Color(0xFF1E1E1E);
  static const Color softGrey = Color(0xFFF7F8FA);
  static const Color paleGrey = Color(0xFFF1F3F6);

  static final ThemeData theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: primaryGreen,
    useMaterial3: true,
    fontFamily: 'Poppins',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: darkText),
      titleTextStyle: TextStyle(color: darkText, fontSize: 18, fontWeight: FontWeight.w600),
    ),
    textTheme: const TextTheme(
      headlineSmall: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: darkText),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black87),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryGreen,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 18),
      ),
    ),
  );
}
