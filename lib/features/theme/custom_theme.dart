import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/core.dart';
import 'theme_export.dart';

class CustomTheme {
  static const double _buttonFontSize = 16.0;
  static const double _appBarElevation = 0;

  static ThemeData darkTheme() {
    final theme = ThemeData.dark();
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.dark,
        primarySwatch: MaterialColor(
          Colors.lightBlue.shade300.value,
          const {
            100: Palette.appColor100,
            200: Palette.appColor200,
            300: Palette.appColor300,
            400: Palette.appColor400,
            500: Palette.appColor500,
            600: Palette.appColor600,
            700: Palette.appColor700,
            800: Palette.appColor800,
            900: Palette.appColor900,
          },
        ),
        accentColor: Colors.lightBlue,
      ),
      scaffoldBackgroundColor: Palette.black,
      appBarTheme: const AppBarTheme(
        elevation: _appBarElevation,
        color: Palette.black,
      ),
      textTheme: theme.primaryTextTheme
          .copyWith(
            button: theme.primaryTextTheme.button?.copyWith(
              color: Colors.white,
              fontSize: _buttonFontSize,
            ),
          )
          .apply(displayColor: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Palette.appColor500,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          enableFeedback: true,
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.padding12,
              vertical: AppConstants.padding12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
      ),
    );
  }

  static ThemeData lightTheme() {
    final theme = ThemeData.light();
    return ThemeData(
      colorScheme: ColorScheme.fromSwatch(
        brightness: Brightness.light,
        primarySwatch: MaterialColor(
          Colors.lightBlue.shade300.value,
          const {
            100: Palette.appColor100,
            200: Palette.appColor200,
            300: Palette.appColor300,
            400: Palette.appColor400,
            500: Palette.appColor500,
            600: Palette.appColor600,
            700: Palette.appColor700,
            800: Palette.appColor800,
            900: Palette.appColor900,
          },
        ),
        accentColor: Colors.lightBlue,
      ),
      scaffoldBackgroundColor: Colors.lightBlue.shade300,
      appBarTheme: const AppBarTheme(
          elevation: _appBarElevation,
          systemOverlayStyle:
              SystemUiOverlayStyle(statusBarBrightness: Brightness.dark),
          // color: Palette.white,
          foregroundColor: Colors.white),
      textTheme: theme.primaryTextTheme
          .copyWith(
            button: theme.primaryTextTheme.button?.copyWith(
              color: Colors.white,
              fontSize: _buttonFontSize,
            ),
          )
          .apply(displayColor: Colors.white, bodyColor: Colors.white),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          backgroundColor: Palette.appColor500,
        ),
      ),
      canvasColor: Colors.lightBlue.shade400,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          textStyle: const TextStyle(
            color: Colors.white,
          ),
          enableFeedback: true,
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.padding12,
              vertical: AppConstants.padding12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.borderRadius),
          ),
        ),
      ),
    );
  }
}
