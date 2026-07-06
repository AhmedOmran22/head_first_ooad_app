import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  static const background = Color(0xFF121212);
  static const surface = Color(0xFF1E1E1E);
  static const surfaceElevated = Color(0xFF262626);
  static const accent = Color(0xFFE8974E);
  static const accentDim = Color(0xFF8A5A2C);
  static const textPrimary = Color(0xFFF5F1EA);
  static const textSecondary = Color(0xFFA8A29A);
  static const codeBackground = Color(0xFF17171A);
  static const divider = Color(0x1FFFFFFF);
}

class AppSpacing {
  AppSpacing._();

  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const xxl = 48.0;
}

class AppTheme {
  AppTheme._();

  static ThemeData get dark {
    final base = ThemeData.dark(useMaterial3: true);
    return base.copyWith(
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: base.colorScheme.copyWith(
        primary: AppColors.accent,
        secondary: AppColors.accent,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
      ),
      textTheme: GoogleFonts.interTextTheme(base.textTheme).apply(
        bodyColor: AppColors.textPrimary,
        displayColor: AppColors.textPrimary,
      ),
      dividerColor: AppColors.divider,
    );
  }

  static TextStyle get monoStyle => GoogleFonts.jetBrainsMono(
        color: AppColors.textPrimary,
        fontSize: 13,
        height: 1.5,
      );
}
