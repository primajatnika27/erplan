import 'package:flutter/material.dart';
// default shape button
RoundedRectangleBorder get _defaultShape => RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(5),
    );

// default color button for handle disable or enable button
Color _defaultColor(Set<MaterialState> states) {
  if (states.contains(MaterialState.disabled)) {
    return AppColor.PRIMARY.withOpacity(0.7);
  }
  return AppColor.PRIMARY;
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.SECONDARY_DARK,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColor.SECONDARY_DARK,
    ),
    backgroundColor: AppColor.BACKGROUND_DARK,
    dialogBackgroundColor: AppColor.SECONDARY_DARK,
    highlightColor: AppColor.GREY,
    dividerColor: AppColor.SECONDARY_DARK,
    canvasColor: AppColor.BACKGROUND_LIGHT,
    cardColor: AppColor.SECONDARY_DARK,
    secondaryHeaderColor: AppColor.SECONDARY_DARK,
    hintColor: AppColor.SECONDARY_DARK,
    indicatorColor: AppColor.PRIMARY,
    unselectedWidgetColor: Colors.white,
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColor.BACKGROUND_LIGHT.withOpacity(0.2),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColor.PRIMARY,
      secondary: AppColor.SECONDARY,
      error: AppColor.ERROR,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        padding: EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        shape: _defaultShape,
        elevation: 0,
      ).copyWith(
        foregroundColor: MaterialStateProperty.resolveWith(
          (states) => AppColor.BACKGROUND_LIGHT,
        ),
        backgroundColor: MaterialStateProperty.resolveWith(
          (states) => _defaultColor(states),
        ),
      ),
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.SECONDARY,
    appBarTheme: AppBarTheme(
      brightness: Brightness.dark,
      textTheme: TextTheme(
        headline6: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: AppColor.SECONDARY,
    ),
    backgroundColor: AppColor.BACKGROUND_LIGHT,
    dialogBackgroundColor: AppColor.BACKGROUND_LIGHT,
    dividerColor: AppColor.GREY_LIGHT_TWO,
    canvasColor: AppColor.SECONDARY,
    cardColor: AppColor.BACKGROUND_LIGHT,
    secondaryHeaderColor: AppColor.PRIMARY_LIGHT,
    indicatorColor: AppColor.PRIMARY_TWO,
    unselectedWidgetColor: Colors.grey,
    hintColor: AppColor.PRIMARY_LIGHT,
    colorScheme: ColorScheme.light(
      primary: AppColor.PRIMARY,
      secondary: AppColor.SECONDARY,
      error: AppColor.ERROR,
    ),
  );
}

class AppColor {
  static const PRIMARY = Color.fromRGBO(68, 156, 208, 1);
  static const PRIMARY_TWO = Color.fromRGBO(54, 109, 163, 1);
  static const PRIMARY_LIGHT = Color.fromRGBO(206, 229, 237, 1);
  static const SECONDARY = Color.fromRGBO(36, 49, 104, 1);
  static const SECONDARY_DARK = Color.fromRGBO(42, 48, 60, 1);
  static const GREY = Color.fromRGBO(113, 121, 140, 1);

  static const GREY_LIGHT = Color.fromRGBO(196, 196, 196, 1);
  static const GREY_LIGHT_TWO = Color.fromRGBO(246, 246, 246, 1);

  static const BACKGROUND_LIGHT = Colors.white;
  static const BACKGROUND_DARK = Color.fromRGBO(31, 38, 48, 1);
  static const BACKGROUND_DARK_TWO = Color.fromRGBO(19, 23, 34, 1);
  static const ERROR = Color.fromRGBO(246, 70, 93, 1);
  static const INFO = Color.fromRGBO(246, 183, 7, 1);

// static const WARNING = Color.fromRGBO(253, 183, 26, 1);
  static const SUCCESS = Color.fromRGBO(69, 182, 141, 1);
// static const DARK_SUCCESS = Color.fromRGBO(81, 149, 72, 1);
}
