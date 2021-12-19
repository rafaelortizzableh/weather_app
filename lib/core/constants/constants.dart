import 'package:flutter/material.dart';

class AppConstants {
  static const String apiKey = String.fromEnvironment('WEATHER_API');

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  static const double borderRadius = 8.0;
  static const double mediumSpacing = 24.0;
  static const double padding4 = 4.0;
  static const double padding8 = 8.0;
  static const double padding12 = 12.0;
  static const double listItemSpacing = 8.0;
}
