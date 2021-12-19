import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../features/features.dart';
import '../../core/core.dart';

final weatherServiceProvider = Provider<WeatherService>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);
  final sharedPreferencesService = ref.watch(sharedPreferencesServiceProvider);

  return OpenWeatherService(
    weatherRepository: weatherRepository,
    sharedPreferencesService: sharedPreferencesService,
  );
});

abstract class WeatherService {
  Future<Result<Failure, List<WeatherModel>>> getLondonFiveDayForecast();
  Future<Result<Failure, WeatherModel>> getLondonWeather();
  Future<Result<Failure, bool>> saveWeatherLocally(WeatherModel weatherModel);
  Future<Result<Failure, bool>> saveForecastLocally(
      List<WeatherModel> forecast);
}

class OpenWeatherService implements WeatherService {
  const OpenWeatherService(
      {required this.weatherRepository,
      required this.sharedPreferencesService});
  final WeatherRepository weatherRepository;
  final SharedPreferencesService sharedPreferencesService;

  @override
  Future<Result<Failure, List<WeatherModel>>> getLondonFiveDayForecast() async {
    try {
      final forecastEntitiesList =
          await weatherRepository.getLondonFiveDayForecast();
      final mappedList = forecastEntitiesList
          .map((forecast) => WeatherModel.fromEntity(forecast))
          .toList();
      return Success(mappedList);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

  @override
  Future<Result<Failure, WeatherModel>> getLondonWeather() async {
    try {
      final currentWeather = await weatherRepository.getLondonWeather();
      final mappedWeather = WeatherModel.fromEntity(currentWeather);
      return Success(mappedWeather);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

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
