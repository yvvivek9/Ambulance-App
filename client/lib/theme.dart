import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final colorScheme = ColorScheme.fromSeed(seedColor: Colors.lightBlueAccent);

final themeData = ThemeData(
  useMaterial3: true,
  colorScheme: colorScheme,
  textTheme: TextTheme(
    headlineMedium: GoogleFonts.emilysCandy(
      fontSize: 23,
      fontWeight: FontWeight.w700,
      color: colorScheme.primary,
    ),
    titleLarge: GoogleFonts.roboto(
      fontSize: 23,
      fontWeight: FontWeight.w700,
      color: colorScheme.primary,
    ),
    titleMedium: GoogleFonts.roboto(
      fontSize: 20,
      fontWeight: FontWeight.w700,
      color: colorScheme.secondary,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontSize: 17,
      fontWeight: FontWeight.w500,
      color: colorScheme.onSecondaryContainer,
    ),
    labelMedium: GoogleFonts.roboto(
      fontSize: 14,
      color: colorScheme.onInverseSurface,
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
