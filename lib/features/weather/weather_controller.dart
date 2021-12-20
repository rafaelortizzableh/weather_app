import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:weather_app/core/core.dart';
import '../features.dart';

final weatherControllerProvider =
    StateNotifierProvider.autoDispose<WeatherController, WeatherState>(
  (ref) => WeatherController(
    WeatherState(
      lastUpdate: DateTime.now(),
      forecast: const AsyncValue.data([]),
      currentWeather: AsyncValue.data(WeatherModel.initial()),
    ),
    weatherService: ref.watch(weatherServiceProvider),
  ),
);

class WeatherController extends StateNotifier<WeatherState> {
  WeatherController(WeatherState state, {required this.weatherService})
      : super(state) {
    getWeatherData();
  }
  final WeatherService weatherService;

  Future<void> getWeatherData() async {
    state = state.copyWith(
        forecast: const AsyncValue.loading(),
        currentWeather: const AsyncValue.loading(),
        lastUpdate: DateTime.now());
    final forecastRequest = weatherService.getRemoteLondonFiveDayForecast();
    final currentWeatherRequest = weatherService.getRemoteLondonWeather();
    final result = await Future.wait([forecastRequest, currentWeatherRequest]);

    final forecastResult = result[0] as Result<Failure, List<WeatherModel>>;
    final currentWeatherResult = result[1] as Result<Failure, WeatherModel>;

    forecastResult.when(
      (error) {
        if (error.code == 999 &&
            weatherService.getLocalLondonFiveDayForecast() is! Failure) {
          final localWeatherForecast =
              weatherService.getLocalLondonFiveDayForecast();

          localWeatherForecast.when(
            (error) => state = state.copyWith(
              forecast: AsyncValue.error(error),
            ),
            (forecast) => state = state.copyWith(
              forecast: AsyncValue.data(forecast),
            ),
          );
        } else {
          state = state.copyWith(forecast: AsyncValue.error(error));
        }
      },
      (forecast) {
        weatherService.saveForecastLocally(forecast);
        return state = state.copyWith(
          forecast: AsyncValue.data(forecast),
        );
      },
    );

    currentWeatherResult.when((error) {
      if (error.code == 999 &&
          weatherService.getLocalLondonWeather() is! Failure) {
        final localWeather = weatherService.getLocalLondonWeather();

        localWeather.when(
          (error) => state = state.copyWith(
            currentWeather: AsyncValue.error(error),
          ),
          (weather) => state = state.copyWith(
            currentWeather: AsyncValue.data(weather),
          ),
        );
      } else {
        state = state.copyWith(forecast: AsyncValue.error(error));
      }
    }, (weather) {
      weatherService.saveWeatherLocally(weather);
      return state = state.copyWith(currentWeather: AsyncValue.data(weather));
    });
  }
}
