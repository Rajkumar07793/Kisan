import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kisan_app/core/constants/app_colors.dart';

class AppTypography {
  // --- BASE SPECIFICATIONS ---
  static const String fontFamily = 'Inter';

  // --- SEMANTIC STYLES ---

  /// 30px | ExtraBold (800) | -0.75 Spacing | height 1.2
  /// Primarily used for Featured Trip headers.
  static final TextStyle headlineExtraBold = GoogleFonts.inter(
    fontSize: 30,
    fontWeight: FontWeight.w800,
    letterSpacing: -0.75,
    height: 1.2,
    color: AppColors.textPrimaryLight,
  );

  /// 24px | Bold (700)
  /// Used for standard section headers (Ongoing, Upcoming).
  static final TextStyle sectionHeader = GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryLight,
  );

  /// 18px | Bold (700)
  /// Used for Card titles and prominent list items.
  static final TextStyle cardTitle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimaryLight,
  );

  /// 16px | Regular (400)
  /// Standard body text for descriptions.
  static final TextStyle bodyRegular = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimaryLight,
  );

  /// 14px | Medium (500)
  /// Secondary text, locations, and host attribution.
  static final TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: Colors.grey[600],
  );

  /// 12px | Regular/Medium (400/500)
  /// Date ranges and small captions.
  static final TextStyle caption = GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Colors.grey[600],
  );

  // --- THEME MAPPING ---
  static TextTheme get textTheme => TextTheme(
    headlineLarge: headlineExtraBold,
    headlineMedium: sectionHeader,
    titleLarge: cardTitle,
    titleMedium: cardTitle.copyWith(fontSize: 16), // Smaller variation
    bodyLarge: bodyRegular,
    bodyMedium: bodyMedium,
    bodySmall: caption,
    labelLarge: bodyMedium.copyWith(
      fontSize: 14,
      color: AppColors.primary,
    ), // Buttons
    labelSmall: caption.copyWith(fontSize: 10),
  );
}
