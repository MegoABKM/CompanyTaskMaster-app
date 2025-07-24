import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:companymanagment/core/services/services.dart';

class AppThemes {
  static final MyServices myServices = Get.find<MyServices>();

  // Shared text theme for consistency across the app.
  static TextTheme getCommonTextTheme() => const TextTheme(
        displayLarge: TextStyle(fontSize: 96, fontWeight: FontWeight.bold),
        displayMedium: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
        displaySmall: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        headlineMedium: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w600), // Slightly less bold
        bodyLarge: TextStyle(fontSize: 16),
        bodyMedium: TextStyle(fontSize: 14),
        bodySmall: TextStyle(fontSize: 12),
        labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      );

  // A modern, consistent input decoration for text fields.
  static InputDecorationTheme _modernInputDecorationTheme(
    ColorScheme colorScheme,
  ) {
    return InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.surface, // Use the card/surface color
      contentPadding:
          const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(
          color: colorScheme.onSurface.withOpacity(0.1),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: BorderSide(color: colorScheme.primary, width: 2),
      ),
      hintStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.4)),
      labelStyle: TextStyle(
        color: colorScheme.onSurface.withOpacity(0.7),
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // --- NEW UNIFIED COLOR PALETTE FOCUSED ON TEAMWORK & PROFESSIONALISM ---
  static final Map<String, Color> availableColors = {
    // --- NEW: "Corporate Synergy" Palette ---
    'synergyBlue': const Color(0xFF005A9C),
    'innovationTeal': const Color(0xFF13A49E),
    'productivityOrange': const Color(0xFFF79009),
    'leadershipPurple': const Color(0xFF6941C6),

    // --- Other Professional Colors ---
    'dangerRed': const Color(0xFFDC3545),
    'successGreen': const Color(0xFF198754),
    'modernSlate': const Color(0xFF344054),
  };

  // Helper methods now default to the new professional blue.
  static Color getPrimaryColor() {
    String? colorKey = myServices.sharedPreferences.getString('PrimaryColor');
    return availableColors[colorKey] ?? availableColors['synergyBlue']!;
  }

  // Secondary color is kept separate for future flexibility, but defaults to the primary.
  static Color getSecondaryColor() {
    String? colorKey = myServices.sharedPreferences.getString('SecondColor');
    return availableColors[colorKey] ?? availableColors['synergyBlue']!;
  }

  // --- REBUILT THEMES ---

  /// The new default "Corporate Synergy" light theme.
  static ThemeData lightTheme(String languageCode) {
    final primaryAccent = getPrimaryColor();
    const backgroundColor = Color(0xFFF5F7FA); // Light, cool gray background
    const cardColor = Colors.white;
    const textColor = Color(0xFF344054); // Dark slate gray for text

    final colorScheme = ColorScheme.light(
      primary: primaryAccent,
      onPrimary: Colors.white,
      secondary: primaryAccent,
      onSecondary: Colors.white,
      surface: cardColor,
      onSurface: textColor,
      background: backgroundColor,
      onBackground: textColor,
      error: const Color(0xFFD92D20),
      onError: Colors.white,
    );

    return ThemeData(
      fontFamily: languageCode == "ar" ? "Tajawal" : "OpenSans",
      brightness: Brightness.light,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      colorScheme: colorScheme,
      textTheme: getCommonTextTheme().apply(
        bodyColor: textColor,
        displayColor: textColor,
        fontFamily: languageCode == "ar" ? "Tajawal" : "OpenSans",
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        foregroundColor: textColor,
        iconTheme: IconThemeData(color: textColor.withOpacity(0.8)),
        titleTextStyle: TextStyle(
          fontFamily: languageCode == "ar" ? "Tajawal" : "OpenSans",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
      inputDecorationTheme: _modernInputDecorationTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          elevation: 1, // Subtle shadow
          textStyle: TextStyle(
            fontFamily: languageCode == "ar" ? "Tajawal" : "OpenSans",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      iconTheme: IconThemeData(color: primaryAccent, size: 24),
      dividerColor: textColor.withOpacity(0.1),
    );
  }

  /// The new default "Corporate Synergy" dark theme.
  static ThemeData darkTheme(String languageCode) {
    final primaryAccent = getPrimaryColor();
    const backgroundColor = Color(0xFF1D2939); // Deep slate background
    const cardColor = Color(0xFF344054);
    const lightTextColor = Color(0xFFE4E7EC);

    final colorScheme = ColorScheme.dark(
      primary: primaryAccent,
      onPrimary: Colors.white,
      secondary: primaryAccent,
      onSecondary: Colors.white,
      surface: cardColor,
      onSurface: lightTextColor,
      background: backgroundColor,
      onBackground: lightTextColor,
      error: const Color(0xFFF04438),
      onError: Colors.white,
    );

    return ThemeData(
      fontFamily: languageCode == "ar" ? "Tajawal" : "OpenSans",
      brightness: Brightness.dark,
      scaffoldBackgroundColor: backgroundColor,
      cardColor: cardColor,
      colorScheme: colorScheme,
      textTheme: getCommonTextTheme().apply(
        bodyColor: lightTextColor.withOpacity(0.8),
        displayColor: lightTextColor,
        fontFamily: languageCode == "ar" ? "Tajawal" : "OpenSans",
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        centerTitle: true,
        foregroundColor: lightTextColor,
        titleTextStyle: TextStyle(
          fontFamily: languageCode == "ar" ? "Tajawal" : "OpenSans",
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lightTextColor,
        ),
      ),
      inputDecorationTheme: _modernInputDecorationTheme(colorScheme),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryAccent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          elevation: 1,
          textStyle: TextStyle(
            fontFamily: languageCode == "ar" ? "Tajawal" : "OpenSans",
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      iconTheme: IconThemeData(color: primaryAccent, size: 24),
      dividerColor: Colors.white.withOpacity(0.15),
    );
  }
}
