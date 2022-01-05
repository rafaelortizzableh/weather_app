import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core.dart';

class SharedPreferencesService {
  final SharedPreferences prefs;

  SharedPreferencesService(this.prefs);

  bool? get getOnboardingDone => prefs.getBool('onboardingDone');

  String? get getLastWeatherData => prefs.getString('lastWeatherData');

  List<String>? get getLastForecastData =>
      prefs.getStringList('lastForecastData');

  String? get getUserTheme => prefs.getString('selectedTheme');

  Future<bool> saveOnboardingCompleted(bool onboardingCompleted) async {
    try {
      return await prefs.setBool('onboardingDone', onboardingCompleted);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> saveWeatherData(String weatherData) async {
    try {
      return await prefs.setString('lastWeatherData', weatherData);
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<bool> saveForecastData(List<String> lastForecastData) async {
    try {
      return await prefs.setStringList('lastForecastData', lastForecastData);
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(message: 'Could not save forecast');
    }
  }

  Future<bool> setPreferredTheme(String theme) async {
    try {
      return await prefs.setString('selectedTheme', theme);
    } catch (e) {
      debugPrint(e.toString());
      throw Failure(message: 'Could not save current weather');
    }
  }
}
