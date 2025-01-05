import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFFFF520D),
  onPrimary: Color(0xFFFFFFFF),
  secondary: Color(0xFFFEA82F),
  onSecondary: Colors.black87,
  tertiary: Color(0xFFFFC288),
  onTertiary: Colors.black54,
  surface: Color(0xFFFFFFFF),
  onSurface: Colors.black54,
  error: Colors.redAccent,
  onError: Colors.white70,
);

final themeData = ThemeData(
  useMaterial3: true,
  colorScheme: colorScheme,
  textTheme: TextTheme(
    headlineLarge: GoogleFonts.gabriela(
      fontSize: 50,
      fontWeight: FontWeight.w700,
      color: colorScheme.onPrimary,
    ),
    headlineMedium: GoogleFonts.emilysCandy(
      fontSize: 23,
      fontWeight: FontWeight.w700,
      color: colorScheme.primary,
    ),
    headlineSmall: GoogleFonts.arvo(
      fontSize: 15,
      fontWeight: FontWeight.w600,
      color: colorScheme.onPrimary,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 23,
      fontWeight: FontWeight.w700,
      color: colorScheme.primary,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w700,
      color: colorScheme.onSecondary,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      color: colorScheme.onSecondary,
    ),
    bodySmall: GoogleFonts.roboto(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: 13,
      fontWeight: FontWeight.w700,
      color: Colors.black54,
    ),
    labelSmall: GoogleFonts.roboto(
      fontSize: 10,
      fontWeight: FontWeight.w700,
      color: Colors.black54,
    ),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: colorScheme.primary,
    foregroundColor: colorScheme.onPrimary,
    titleTextStyle: GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: colorScheme.primary,
      foregroundColor: colorScheme.onPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      padding: EdgeInsets.symmetric(vertical: 20),
      textStyle: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),
    ),
  ),
);
