import 'package:flutter/material.dart';
import 'package:kisan_app/l10n/generated/app_localizations.dart';

extension ContextExtensions on BuildContext {
  // Localization shortcut
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  // Theme shortcuts
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Media Query shortcuts
  double get screenHeight => MediaQuery.sizeOf(this).height;
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get aspectRatio => MediaQuery.sizeOf(this).aspectRatio;
  Orientation get orientation => MediaQuery.orientationOf(this);

  // Insets and Padding
  double get topPadding => MediaQuery.paddingOf(this).top;
  double get bottomPadding => MediaQuery.paddingOf(this).bottom;
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;

  // Responsive Breakpoints (Example)
  bool get isMobile => screenWidth < 600;
  bool get isTablet => screenWidth >= 600 && screenWidth < 1200;
  bool get isDesktop => screenWidth >= 1200;

  // Device Pixel Ratio
  double get pixelRatio => MediaQuery.devicePixelRatioOf(this);

  // Navigation shortcuts
  void popPage<T>([T? result]) => Navigator.of(this).pop(result);
}

extension SpacingExtensions on num {
  Widget get heightBox => SizedBox(height: toDouble());
  Widget get widthBox => SizedBox(width: toDouble());
}
