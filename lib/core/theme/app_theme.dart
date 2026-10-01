import 'package:flutter/material.dart';

abstract final class AppColors {
  static const navy = Color(0xFF071A2B);
  static const deepBlue = Color(0xFF09446E);
  static const blue = Color(0xFF3F7BAB);
  static const gold = Color(0xFFE3AD39);
  static const text = Color(0xFFF5F7FA);
  static const muted = Color(0xFFD9D9D9);
  static const field = Color(0xFF0B2235);
}

abstract final class AppTheme {
  static ThemeData get dark => ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: AppColors.navy,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.gold,
      secondary: AppColors.blue,
      surface: AppColors.deepBlue,
      error: Color(0xFFFF8A80),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.text,
        fontSize: 30,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(color: AppColors.muted, fontSize: 15),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.field,
      hintStyle: const TextStyle(color: AppColors.muted),
      labelStyle: const TextStyle(color: AppColors.muted),
      prefixIconColor: AppColors.blue,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 17),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.blue.withValues(alpha: 0.35)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: AppColors.blue.withValues(alpha: 0.35)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.gold, width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF8A80)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFFF8A80), width: 1.5),
      ),
    ),
  );
}
