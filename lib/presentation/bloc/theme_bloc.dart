import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logging/logging.dart';

abstract class ThemeState extends Equatable {
  final ThemeMode themeMode;

  ThemeState({
    this.themeMode = ThemeMode.dark,
  });

  @override
  List<Object> get props => [
        themeMode,
      ];
}

class ThemeInitialState extends ThemeState {
  ThemeInitialState() : super();
}

class ThemeLoadedState extends ThemeState {
  final DateTime time;

  ThemeLoadedState({required ThemeMode themeMode})
      : time = DateTime.now(),
        super(themeMode: themeMode);

  @override
  List<Object> get props => [time];
}

class ThemeBloc extends Cubit<ThemeState> {
  final Logger logger = Logger('ThemeBloc');

  ThemeBloc() : super(ThemeInitialState());

  Future<void> changeTheme({required bool isDarkMode}) async {
    emit(ThemeLoadedState(
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    ));
  }
}
