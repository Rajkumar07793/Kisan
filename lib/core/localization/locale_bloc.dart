import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/providers/local/storage_service.dart';

part 'locale_event.dart';
part 'locale_state.dart';

class LocaleBloc extends Bloc<LocaleEvent, LocaleState> {
  final StorageService _storageService;
  static const String _localeKey = 'user_locale_code';

  LocaleBloc({required StorageService storageService})
    : _storageService = storageService,
      super(const LocaleState(Locale('en'))) {
    on<ChangeLocale>(_onChangeLocale);
    on<LoadLocale>(_onLoadLocale);
  }

  void _onChangeLocale(ChangeLocale event, Emitter<LocaleState> emit) {
    _storageService.setString(_localeKey, event.locale.languageCode);
    emit(LocaleState(event.locale));
  }

  void _onLoadLocale(LoadLocale event, Emitter<LocaleState> emit) {
    final savedLocaleCode = _storageService.getString(_localeKey);
    if (savedLocaleCode != null) {
      emit(LocaleState(Locale(savedLocaleCode)));
    }
  }
}
