import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';
import 'package:path_provider/path_provider.dart';

import '../../config/constant_config.dart';
import '../../data/model/core/language_model.dart';
import '../../domain/repository/language_repository_local.dart';
import '../../domain/repository/language_repository_remote.dart';

/// State for language bloc
abstract class LanguageState extends Equatable {
  final Locale locale;

  LanguageState({this.locale = Locales.en});

  @override
  List<Object> get props => [locale];
}

/// Default language state
class LanguageDefaultState extends LanguageState {
  LanguageDefaultState() : super(locale: _defaultLocale);

  // get default locale
  static Locale get _defaultLocale {
    if (Locales.supported.contains(window.locale)) {
      return window.locale;
    }
    return Locales.en;
  }
}

/// State after saved preferences language has been loaded
class LanguageLoadedState extends LanguageState {
  /// Mark if language setting is loaded from preferences
  final bool fromLocalData;

  LanguageLoadedState({
    required Locale locale,
    required this.fromLocalData,
  }) : super(locale: locale);

  @override
  List<Object> get props => [locale, fromLocalData];
}

/// Bloc Language
class LanguageBloc extends Cubit<LanguageState> {
  final LanguageRepositoryLocal repositoryLocal;
  final LanguageRepositoryRemote repositoryRemote;

  late String _pathLanguage;
  late File _fileLanguage;
  late Directory _dirLanguage;

  final Logger _logger = Logger("Language Bloc");

  LanguageBloc({
    required this.repositoryLocal,
    required this.repositoryRemote,
  }) : super(LanguageDefaultState());

  void loadTranslation() async {
    _logger.fine('load translation');

    // get data from server
    LanguageModel response = await repositoryRemote.get();

    // get local directory
    Directory? local = (Platform.isAndroid)
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    // set path for file language
    _pathLanguage = local!.path + Platform.pathSeparator + 'Language';

    // set directory language
    _dirLanguage = Directory(_pathLanguage);

    // set file language
    _fileLanguage = File(_dirLanguage.path + '/language.json');

    // check file is existed
    bool fileExisted = _fileLanguage.existsSync();
    _logger.fine("file is exist: $fileExisted");

    if (!fileExisted) {
      // download file
      await downloadTranslation(url: response.url);
    } else {
      // check version
      int serverVersion = response.version;

      Map<String, dynamic> json = jsonDecode(_fileLanguage.readAsStringSync());
      int currentVersion = json["version"];

      _logger.fine("version: $currentVersion, new version: $serverVersion");
      if (serverVersion > currentVersion) {
        // download file
        await downloadTranslation(url: response.url);
      }
    }

    loadLocal();
  }

  Future<void> downloadTranslation({required String url}) async {
    _logger.fine("download translation. url: $url");
    // check directory exist
    if (!_dirLanguage.existsSync()) {
      _logger.fine("create directory because directory is not exist");
      // create directory
      _dirLanguage.createSync();
    }

    // check file exist
    if (!_fileLanguage.existsSync()) {
      _logger.fine("create file because file is not exist");
      // create file
      _fileLanguage.createSync();
    }

    // download file
    Dio dio = Dio();
    await dio.download(url, _fileLanguage.path);
    _logger.fine("download translation success");
  }

  Future<void> loadLocal() async {
    _logger.fine('Load locale data from shared preferences');
    Locale? locale = await repositoryLocal.load();

    if (locale == null) {
      _logger.fine('Locale data not found');
      emit(LanguageLoadedState(
        fromLocalData: false,
        locale: state.locale,
      ));
      return;
    }

    _logger.fine('Locale found: ' + locale.toString());

    emit(LanguageLoadedState(
      fromLocalData: true,
      locale: locale,
    ));
  }

  /// Just change the locale, not affecting the from local data
  void change(Locale locale) {
    if (state is LanguageLoadedState) {
      _logger.fine('Locale changed: ' + locale.toString());

      emit(LanguageLoadedState(
        fromLocalData: (state as LanguageLoadedState).fromLocalData,
        locale: locale,
      ));

      save();
    }
  }

  /// Save language preferences in local storage
  Future<bool> save() async {
    _logger.fine('Save locale: ' + state.locale.toString());
    return await repositoryLocal.save(state.locale);
  }
}
