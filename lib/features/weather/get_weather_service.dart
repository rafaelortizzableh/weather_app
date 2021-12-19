import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../features/features.dart';
import '../../core/core.dart';

final getWeatherServiceProvider = Provider<GetWeatherService>((ref) {
  final weatherRepository = ref.watch(weatherRepositoryProvider);

  return OpenWeatherService(
    weatherRepository: weatherRepository,
  );
});

abstract class GetWeatherService {
  Future<Result<Failure, List<WeatherModel>>> getLondonFiveDayForecast();
  Future<Result<Failure, WeatherModel>> getLondonWeather();
}

class OpenWeatherService implements GetWeatherService {
  const OpenWeatherService({
    required this.weatherRepository,
  });
  final WeatherRepository weatherRepository;

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
}
