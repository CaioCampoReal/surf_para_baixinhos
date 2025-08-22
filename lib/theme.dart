import 'package:flutter/material.dart';

class AppColors {
  static const primaryBlue = Color(0xFF1565C0);
  static const white = Colors.white;
  static const yellowHighlight = Color(0xFFFFEB3B);
  static const burntYellow = Color(0xFFF9A825);
  static const background = Color(0xFFF5F5F5);
}

final ThemeData appTheme = ThemeData(
  primaryColor: AppColors.primaryBlue,
  scaffoldBackgroundColor: AppColors.background,
  appBarTheme: AppBarTheme(
    backgroundColor: AppColors.primaryBlue,
    foregroundColor: AppColors.white,
    elevation: 2,
    centerTitle: true,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.burntYellow,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(fontWeight: FontWeight.bold),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(vertical: 14),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: AppColors.white,
    labelStyle: TextStyle(color: AppColors.primaryBlue),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: AppColors.primaryBlue, width: 2),
      borderRadius: BorderRadius.circular(8),
    ),
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
    prefixIconColor: AppColors.primaryBlue,
  ),
  textTheme: const TextTheme(
  titleLarge: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
  bodyLarge: TextStyle(color: Colors.black87),
  bodyMedium: TextStyle(color: Colors.black54),
),

);
