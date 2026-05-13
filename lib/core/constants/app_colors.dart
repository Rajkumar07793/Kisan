import 'package:flutter/material.dart';

class AppColors {
  // --- Agricultural Brand Palette ---
  static const Color primary = Color(0xFF2E7D32); // Agricultural Green
  static const Color primaryLight = Color(0xFF60AD5E); // Lighter Green
  static const Color primaryDark = Color(0xFF005005); // Darker Green
  
  static const Color secondary = Color(0xFF795548); // Earthy Brown
  static const Color secondaryLight = Color(0xFFA98274);
  static const Color secondaryDark = Color(0xFF4B2C20);

  // Backgrounds
  static const Color backgroundLight = Color(0xFFF6F6F6);
  static const Color surfaceLight = Colors.white;

  static const Color backgroundDark = Color(0xFF121212);
  static const Color surfaceDark = Color(0xFF1E1E1E);

  // Text Colors
  static const Color textPrimaryLight = Color(0xFF212121);
  static const Color textSecondaryLight = Color(0xFF757575);
  static const Color textHintLight = Color(0xFFBDBDBD);

  static const Color textPrimaryDark = Color(0xFFE0E0E0);
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  // Status Colors
  static const Color success = Color(0xFF4CAF50);
  static const Color error = Color(0xFFF44336);
  static const Color warning = Color(0xFFFFC107);
  static const Color info = Color(0xFF2196F3);

  // Specifics from Figma
  static const Color inputFill = Color(0xFFF8F8F8);
  static const Color divider = Color(0xFFEEEEEE);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primary, primaryLight],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Bottom Navigation
  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color bottomNavBackground = Color(0xFFF9F1F1);
  static const Color color2D2F2F = Color(0xFF2D2F2F);
  static const Color color5A5C5C = Color(0xFF5A5C5C);
  static const Color fillColor = Color(0xFFF0F1F1);
  static const Color pinkColor = Color(0xFFC8E6C9); // Light Green instead of Pink
  static const Color greenColor = Color(0xFF2E7D32);
  static const Color color351685 = Color(0xFF795548); // Brown instead of Purple
  static const Color color5A5C5C99 = Color(0xff5a5c5c99);
  static const Color colorF0F1F1 = Color(0xFFF0F1F1);
  static const Color color111827 = Color(0xFF111827);
  static const Color color64748B = Color(0xFF64748B);
  static const Color color5A5C5CCC = Color(0xff5a5c5ccc);
  static const Color color555555 = Color(0xFF555555);
}
