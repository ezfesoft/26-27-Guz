import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  AppTheme._();

  // KnowUp Official Brand Palette
  static const Color deepNavy = Color(0xFF0F172A);
  static const Color darkSlate = Color(0xFF1E293B);
  static const Color turquoise = Color(0xFF22D3EE);
  static const Color cyanAccent = Color(0xFF06B6D4);
  static const Color turquoiseLight = Color(0xFFCFFAFE);

  // KnowUp Gamification Accents
  static const Color emeraldGreen = Color(0xFF10B981);
  static const Color emeraldDark = Color(0xFF059669);

  static const Color amberGold = Color(0xFFF59E0B);
  static const Color amberDark = Color(0xFFD97706);

  static const Color roseRed = Color(0xFFF43F5E);
  static const Color roseDark = Color(0xFFE11D48);
  static const Color roseLight = Color(0xFFFFE4E6);

  static const Color violetPurple = Color(0xFF8B5CF6);
  static const Color indigoAccent = Color(0xFF6366F1);

  // Backward compatibility aliases mapped to KnowUp Palette
  static const Color duoGreen = emeraldGreen;
  static const Color duoGreenDark = emeraldDark;
  static const Color duoGreenLight = Color(0xFFD1FAE5);

  static const Color duoBlue = turquoise;
  static const Color duoBlueDark = cyanAccent;

  static const Color duoYellow = amberGold;
  static const Color duoYellowDark = amberDark;

  static const Color duoRed = roseRed;
  static const Color duoRedDark = roseDark;
  static const Color duoRedLight = roseLight;

  static const Color duoPurple = violetPurple;
  static const Color duoOrange = amberGold;

  // Primary Theme Tokens
  static const Color primaryColor = deepNavy;
  static const Color primaryLight = darkSlate;
  static const Color primaryDark = Color(0xFF0B1120);

  static const Color secondaryColor = turquoise;
  static const Color accentColor = turquoise;
  static const Color warningColor = amberGold;
  static const Color errorColor = roseRed;

  static const Color backgroundColor = Color(0xFFF8FAFC);
  static const Color cardColor = Colors.white;
  static const Color surfaceColor = Color(0xFFF1F5F9);

  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: deepNavy,
      primary: deepNavy,
      secondary: turquoise,
      tertiary: amberGold,
      surface: surfaceColor,
      error: roseRed,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      textTheme: GoogleFonts.interTextTheme(),
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 1,
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.outfit(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: deepNavy,
        ),
      ),
      cardTheme: CardThemeData(
        color: cardColor,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: deepNavy,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.5,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: deepNavy,
          side: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          textStyle: GoogleFonts.outfit(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFFCBD5E1), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: turquoise, width: 2),
        ),
      ),
    );
  }
}
