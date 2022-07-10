import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

import '../../config/constant_config.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Map<String, String> _localizedStrings = {};

  Future<bool> load() async {
    // Load the language JSON file from storage
    String _fileName = 'language.json';
    String _localPath =
        (await _findLocalPath()) + Platform.pathSeparator + 'Language';

    bool hasExisted = await File('$_localPath/$_fileName').exists();

    print('app localization hasExisted: $hasExisted');

    /**if (hasExisted) {
        // get json from file
        // File _jsonFile = File('$_localPath/$_fileName');
        // Map<String, dynamic> jsonMap = jsonDecode(_jsonFile.readAsStringSync());
        // Map<String, dynamic> jsonResult = jsonMap[locale.languageCode];

        // get json from asset
        String jsonFromAsset =
        await rootBundle.loadString('assets/language/language.json');
        Map<String, dynamic> jsonMap = jsonDecode(jsonFromAsset);
        Map<String, dynamic> jsonResult = jsonMap[locale.languageCode];

        _localizedStrings = jsonResult.map((key, value) {
        return MapEntry(key, value.toString());
        });
        }*/

    String jsonFromAsset =
        await rootBundle.loadString('assets/language/language.json');
    Map<String, dynamic> jsonMap = jsonDecode(jsonFromAsset);
    Map<String, dynamic> jsonResult = jsonMap[locale.languageCode];

    _localizedStrings = jsonResult.map((key, value) {
      return MapEntry(key, value.toString());
    });

    return true;
  }

  Future<String> _findLocalPath() async {
    final directory = (Platform.isAndroid)
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();
    return directory!.path;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key] ?? "$key not found";
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return Locales.supported.contains(locale);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => true;
}
