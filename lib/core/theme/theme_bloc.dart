import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/providers/local/storage_service.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final StorageService _storageService;
  static const String _themeKey = 'user_theme_mode';

  ThemeBloc({required StorageService storageService})
    : _storageService = storageService,
      super(const ThemeState(ThemeMode.light)) {
    on<ThemeChanged>(_onThemeChanged);
    on<LoadTheme>(_onLoadTheme);
  }

  void _onThemeChanged(ThemeChanged event, Emitter<ThemeState> emit) {
    _storageService.setString(_themeKey, event.themeMode.name);
    emit(ThemeState(event.themeMode));
  }

  void _onLoadTheme(LoadTheme event, Emitter<ThemeState> emit) {
    final savedTheme = _storageService.getString(_themeKey);
    if (savedTheme != null) {
      final mode = ThemeMode.values.firstWhere(
        (m) => m.name == savedTheme,
        orElse: () => ThemeMode.system,
      );
      emit(ThemeState(mode));
    }
  }
}
