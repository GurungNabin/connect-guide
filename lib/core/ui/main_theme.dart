
import 'package:connect_me_app/core/ui/colors.dart';
import 'package:flutter/material.dart';

class ThemeConfig {
  static ThemeData get theme {
    return ThemeData(
      scaffoldBackgroundColor: AppTheme.colorWhite,
      primaryColor: const Color(0xFF785ef6),
      hintColor: Colors.red,
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        displayMedium: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.black87,
        ),
        bodyLarge: TextStyle(
          fontSize: 16.0,
          color: Colors.black54,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.0,
          color: Colors.black45,
        ),
      ),
      buttonTheme: const ButtonThemeData(
        buttonColor: Color(0xFF785ef6),
        textTheme: ButtonTextTheme.primary,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF785ef6),
        iconTheme: IconThemeData(
          size: 20,
          color: Colors.white,
        ),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF785ef6),
      ),
      dividerColor: Colors.blueGrey[200],
      cardColor: Colors.white,
      colorScheme: ColorScheme(
        primary: const Color(0xFF785ef6),
        primaryContainer: const Color(0xFF6a4f8b),
        secondary: Colors.teal,
        secondaryContainer: Colors.teal[700]!,
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    );
  }
}
