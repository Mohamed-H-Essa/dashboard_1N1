import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Colors based on the provided images
  static const Color primaryOrange = Color(0xFFFFC268);
  static const Color darkBackground = Color(0xFF000000); // Dark background
  static const Color cardColor = Color(0xFF171717);
  static const Color navbarBackground = Color(
    0xFF0A0A0A,
  ); // Even darker for navbar

  // Status colors
  static const Color statusBorder = Color(0xFFC25F30);
  static const Color usersAvatarBorder = Color(0xFF262626);
  static const Color statusBackground = Color(
    0x1AC25F30,
  ); // C25F30 at 10% opacity
  static const Color orangeYellow = Color(0xFFFFC268);

  static ThemeData get lightTheme {
    return ThemeData(
      primaryColor: primaryOrange,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryOrange,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: navbarBackground,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: navbarBackground),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryOrange,
        ),
      ),
      textTheme: GoogleFonts.interTextTheme(ThemeData.light().textTheme),
      useMaterial3: true,
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primaryColor: primaryOrange,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryOrange,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: const AppBarTheme(
        backgroundColor: navbarBackground,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      drawerTheme: const DrawerThemeData(backgroundColor: navbarBackground),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryOrange,
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      useMaterial3: true,
    );
  }
}
