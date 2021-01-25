import 'dart:ui';

import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => AppLocalizations.isSupported(locale);

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(
      AppLocalizations.translations[locale.languageCode],
    );
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

abstract class AppLocalizations implements LoginWidgetMessages {
  static LocalizationsDelegate<AppLocalizations> get delegate =>
      const _AppLocalizationsDelegate();

  static Map<String, AppLocalizations> get translations => {
        'en': AppLocalizationsEn(),
        'pt': AppLocalizationsPt(),
      };

  static List<Locale> get supportedLocales =>
      translations.keys.map((language) => Locale(language)).toList();

  static bool isSupported(Locale locale) =>
      supportedLocales.map((e) => e.languageCode).contains(locale.languageCode);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get login;
  String get user;
  String get password;
}

class AppLocalizationsEn implements AppLocalizations {
  String get login => 'LOGIN';
  String get user => 'User';
  String get password => 'Password';
}

class AppLocalizationsPt implements AppLocalizations {
  String get login => 'LOGIN';
  String get user => 'Utilizador';
  String get password => 'Senha';
}
