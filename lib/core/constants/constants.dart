import 'package:flutter/material.dart';

class AppConstants {
  static const String apiKey = String.fromEnvironment('WEATHER_API');

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static const webViewUrl =
      'https://openweathermap.org/weathermap?basemap=map&cities=false&layer=temperature%20&lat=51&lon=0&zoom=10';

  static const double borderRadius = 8.0;
  static const double mediumSpacing = 24.0;
  static const double padding4 = 4.0;
  static const double padding8 = 8.0;
  static const double padding12 = 12.0;
  static const double listItemSpacing = 8.0;
}
