import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../config/constant_config.dart';
import '../../config/style_config.dart';
import '../../data/repository_impl/language_repository_impl_local.dart';
import '../../data/repository_impl/language_repository_impl_remote.dart';
import '../bloc/firebase_message_bloc.dart';
import '../bloc/language_bloc.dart';
import '../bloc/theme_bloc.dart';
import 'app_localizations.dart';

class MainApp extends StatefulWidget {
  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final FirebaseMessageBloc _firebaseMessageBloc = FirebaseMessageBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 800),
      builder: () => MultiBlocProvider(
        providers: [
          BlocProvider<LanguageBloc>(
            create: (_) => LanguageBloc(
              repositoryLocal: LanguageRepositoryImplLocal(),
              repositoryRemote: LanguageRepositoryImplRemote(),
            ),
          ),
          BlocProvider<FirebaseMessageBloc>(
            create: (_) => _firebaseMessageBloc,
          ),
          BlocProvider<ThemeBloc>(
            create: (_) => ThemeBloc(),
          ),
          BlocProvider<LanguageBloc>(
            create: (_) => LanguageBloc(
              repositoryLocal: LanguageRepositoryImplLocal(),
              repositoryRemote: LanguageRepositoryImplRemote(),
            ),
          ),
        ],
        child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (context, stateLanguage) =>
              BlocBuilder<ThemeBloc, ThemeState>(
            builder: (context, stateTheme) => MaterialApp(
              initialRoute: "/",
              themeMode: stateTheme.themeMode,
              theme: MyThemes.lightTheme,
              darkTheme: MyThemes.darkTheme,
              debugShowCheckedModeBanner: false,
              locale: stateLanguage.locale,
              supportedLocales: Locales.supported,
              builder: (context, widget) => MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                child: widget!,
              ),
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
            ).modular(),
          ),
        ),
      ),
    );
  }
}
