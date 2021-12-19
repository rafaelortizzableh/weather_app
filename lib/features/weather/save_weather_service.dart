import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../features/features.dart';
import '../../core/core.dart';


final saveWeatherServiceProvider = Provider<SaveWeatherService>((ref) {
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);

  return SharedPreferencesSaveWeatherService(
    sharedPreferencesService: sharedPreferencesService,
  );
});

abstract class SaveWeatherService {
  Future<Result<Failure, bool>> saveWeatherLocally(WeatherModel weatherModel);
  Future<Result<Failure, bool>> saveForecastLocally(
      List<WeatherModel> forecast);
}

class SharedPreferencesSaveWeatherService implements SaveWeatherService {
  const SharedPreferencesSaveWeatherService(
      {required this.sharedPreferencesService});

  final SharedPreferencesService sharedPreferencesService;

  @override
  Future<Result<Failure, bool>> saveForecastLocally(
      List<WeatherModel> forecast) async {
    try {
      final jsonEncodedListOfStrings =
          forecast.map((forecast) => forecast.toJson()).toList();
      final result = await sharedPreferencesService
          .saveForecastData(jsonEncodedListOfStrings);
      return Success(result);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

  @override
  Future<Result<Failure, bool>> saveWeatherLocally(
      WeatherModel weatherModel) async {
    try {
      final jsonEncodedWeather = weatherModel.toJson();
      final result =
          await sharedPreferencesService.saveWeatherData(jsonEncodedWeather);
      return Success(result);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }
}
