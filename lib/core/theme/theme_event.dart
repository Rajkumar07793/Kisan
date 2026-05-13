part of 'theme_bloc.dart';

abstract class ThemeEvent {
  const ThemeEvent();
}

class ThemeChanged extends ThemeEvent {
  final ThemeMode themeMode;
  const ThemeChanged(this.themeMode);
}

class LoadTheme extends ThemeEvent {
  const LoadTheme();
}
