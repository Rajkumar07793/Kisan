part of 'locale_bloc.dart';

abstract class LocaleEvent {
  const LocaleEvent();
}

class ChangeLocale extends LocaleEvent {
  final Locale locale;
  const ChangeLocale(this.locale);
}

class LoadLocale extends LocaleEvent {
  const LoadLocale();
}
