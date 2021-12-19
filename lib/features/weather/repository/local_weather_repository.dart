import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../features/features.dart';
import '../../../../core/core.dart';

final localWeatherRepositoryProvider = Provider<LocalWeatherRepository>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);

  return SharedPreferencesLocalWeatherRepository(
    sharedPreferencesService: sharedPreferencesService,
  );
});

abstract class LocalWeatherRepository {
  Future<bool> saveWeatherLocally(WeatherModel weatherModel);
  Future<bool> saveForecastLocally(List<WeatherModel> forecast);
  WeatherModel getLocalWeather();
  List<WeatherModel> getLocalForecast();
}

class SharedPreferencesLocalWeatherRepository
    implements LocalWeatherRepository {
  const SharedPreferencesLocalWeatherRepository(
      {required this.sharedPreferencesService});

  final SharedPreferencesService sharedPreferencesService;

  @override
  Future<bool> saveForecastLocally(List<WeatherModel> forecast) async {
    try {
      final jsonEncodedListOfStrings =
          forecast.map((forecast) => forecast.toJson()).toList();
      final result = await sharedPreferencesService
          .saveForecastData(jsonEncodedListOfStrings);
      return result;
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  Future<bool> saveWeatherLocally(WeatherModel weatherModel) async {
    try {
      final jsonEncodedWeather = weatherModel.toJson();
      final result =
          await sharedPreferencesService.saveWeatherData(jsonEncodedWeather);
      return result;
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  List<WeatherModel> getLocalForecast() {
    try {
      final result = sharedPreferencesService.getLastForecastData;
      if (result == null || result.isEmpty) {
        throw Failure(message: 'No local forecast found');
      }

      final decodedForecast = result
          .map((encodedString) => WeatherModel.fromJson(encodedString))
          .toList();
      return decodedForecast;
    } on Failure catch (_) {
      rethrow;
    }
  }

  @override
  WeatherModel getLocalWeather() {
    try {
      final result = sharedPreferencesService.getLastWeatherData;

      if (result == null || result.isEmpty) {
        throw Failure(message: 'No local weather found');
      }

      final decodedWeather = WeatherModel.fromJson(result);
      return decodedWeather;
    } on Failure catch (_) {
      rethrow;
    }
  }
}
