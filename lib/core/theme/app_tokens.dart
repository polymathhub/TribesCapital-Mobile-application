import 'package:flutter/material.dart';

abstract final class AppColors {
  static const ink = Color(0xFF171326);
  static const plum = Color(0xFF332052);
  static const purple = Color(0xFF7B43D6);
  static const lilac = Color(0xFFE7D9FF);
  static const canvas = Color(0xFFF8F8FA);
  static const surface = Colors.white;
  static const muted = Color(0xFF706B7C);
  static const line = Color(0xFFE8E5ED);
  static const success = Color(0xFF247A5A);
  static const warning = Color(0xFFB46A2D);
}

abstract final class AppSpacing {
  static const xs = 8.0;
  static const sm = 12.0;
  static const md = 16.0;
  static const lg = 24.0;
  static const xl = 32.0;
  static const page = 22.0;
}

abstract final class AppRadius {
  static const card = 24.0;
  static const pill = 40.0;
}

abstract final class AppBreakpoints {
  static const tablet = 600.0;
  static const desktop = 1024.0;
}

ThemeData buildAppTheme() {
  return ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.canvas,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.purple,
      surface: AppColors.surface,
      brightness: Brightness.light,
    ),
    fontFamily: 'Arial',
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        color: AppColors.ink,
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 1.1,
      ),
      titleLarge: TextStyle(
        color: AppColors.ink,
        fontSize: 20,
        fontWeight: FontWeight.w700,
      ),
      titleMedium: TextStyle(
        color: AppColors.ink,
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      bodyMedium: TextStyle(color: AppColors.muted, fontSize: 14, height: 1.35),
    ),
  );
}
