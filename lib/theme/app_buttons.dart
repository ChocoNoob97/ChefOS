import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_spacing.dart';
import 'app_text_styles.dart';

class AppButtons {
  AppButtons._();

  static final ButtonStyle primary = ElevatedButton.styleFrom(
    backgroundColor: AppColors.primary,
    foregroundColor: Colors.white,
    elevation: 0,
    minimumSize: const Size(double.infinity, 56),
    padding: const EdgeInsets.symmetric(vertical: 18),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
    ),
    textStyle: AppTextStyles.button,
  );

  static final ButtonStyle secondary = OutlinedButton.styleFrom(
    foregroundColor: AppColors.primary,
    minimumSize: const Size(double.infinity, 56),
    padding: const EdgeInsets.symmetric(vertical: 18),
    side: const BorderSide(
      color: AppColors.primary,
      width: 1.2,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(AppSpacing.radius),
    ),
    textStyle: AppTextStyles.button,
  );
}