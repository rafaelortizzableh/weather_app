import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';
import '../../../features/features.dart';
import '../../../core/core.dart';

final weatherServiceProvider = Provider<WeatherService>((ref) {
  final remoteWeatherRepository = ref.watch(remoteWeatherRepositoryProvider);
  final localWeatherRepository = ref.watch(localWeatherRepositoryProvider);

  return RemoteAndLocalWeatherService(
    remoteWeatherRepository: remoteWeatherRepository,
    localWeatherRepository: localWeatherRepository,
  );
});

abstract class WeatherService {
  Future<Result<Failure, List<WeatherModel>>> getRemoteFiveDayForecast(
      Position userLocation);
  Future<Result<Failure, WeatherModel>> getRemoteWeather(Position userLocation);
  Result<Failure, List<WeatherModel>> getLocalFiveDayForecast();
  Result<Failure, WeatherModel> getLocalWeather();
  Future<Result<Failure, bool>> saveWeatherLocally(WeatherModel weatherModel);
  Future<Result<Failure, bool>> saveForecastLocally(
      List<WeatherModel> forecast);
}

class RemoteAndLocalWeatherService implements WeatherService {
  const RemoteAndLocalWeatherService(
      {required this.remoteWeatherRepository,
      required this.localWeatherRepository});
  final RemoteWeatherRepository remoteWeatherRepository;
  final LocalWeatherRepository localWeatherRepository;

  @override
  Future<Result<Failure, List<WeatherModel>>> getRemoteFiveDayForecast(
      Position userLocation) async {
    try {
      final forecastEntitiesList =
          await remoteWeatherRepository.getFiveDayForecast(userLocation);
      final mappedList = forecastEntitiesList
          .map((forecast) => WeatherModel.fromEntity(forecast))
          .toList();
      return Success(mappedList);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

  @override
  Future<Result<Failure, WeatherModel>> getRemoteWeather(
      Position userLocation) async {
    try {
      final currentWeather =
          await remoteWeatherRepository.getUserWeather(userLocation);
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
      final result = await localWeatherRepository.saveForecastLocally(forecast);
      return Success(result);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

  @override
  Future<Result<Failure, bool>> saveWeatherLocally(
      WeatherModel weatherModel) async {
    try {
      final result =
          await localWeatherRepository.saveWeatherLocally(weatherModel);
      return Success(result);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

  @override
  Result<Failure, List<WeatherModel>> getLocalFiveDayForecast() {
    try {
      final result = localWeatherRepository.getLocalForecast();
      return Success(result);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }

  @override
  Result<Failure, WeatherModel> getLocalWeather() {
    try {
      final result = localWeatherRepository.getLocalWeather();
      return Success(result);
    } on Failure catch (failure) {
      return Error(failure);
    }
  }
}
