import 'dart:ui';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/repository/language_repository_local.dart';

class LanguageRepositoryImplLocal extends LanguageRepositoryLocal {
  /// Shared preferences key
  static const String key = 'language';

  @override
  Future<Locale?> load() async {
    SharedPreferences sp = await Modular.getAsync<SharedPreferences>();
    if (sp.containsKey(key)) {
      List<String> savedLocale = sp.getStringList(key) ?? [];

      return Locale(savedLocale[0], savedLocale[1]);
    }

    return null;
  }

  @override
  Future<bool> save(Locale locale) async {
    SharedPreferences sp = await Modular.getAsync<SharedPreferences>();
    List<String> localeData = [
      locale.languageCode,
      locale.countryCode ?? '',
    ];

    return sp.setStringList(key, localeData);
  }
}
