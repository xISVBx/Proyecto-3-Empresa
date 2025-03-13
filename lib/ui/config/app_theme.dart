import 'package:col_moda_empresa/ui/config/app_colors.dart';
import 'package:flutter/material.dart';

/// 🎨 Tema de la app basado en el color primario
class AppTheme {
  /// Devuelve el tema configurado con el color primario
  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light, // Puedes cambiar a `Brightness.dark` si es necesario
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: AppColors.accent,
        ),
      );
}
