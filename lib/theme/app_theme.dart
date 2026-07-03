import 'package:flutter/material.dart';

import 'app_buttons.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      foregroundColor: AppColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    ),

    textTheme: const TextTheme(
      displayLarge: AppTextStyles.heroTitle,
      headlineLarge: AppTextStyles.screenTitle,
      headlineSmall: AppTextStyles.sectionTitle,
      bodyLarge: AppTextStyles.body,
      bodyMedium: AppTextStyles.subtitle,
      bodySmall: AppTextStyles.caption,
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: AppButtons.primary,
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: AppButtons.secondary,
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    cardTheme: CardThemeData(
      elevation: 0,
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color: AppColors.border,
        ),
      ),
    ),
  );
}