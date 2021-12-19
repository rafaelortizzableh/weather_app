import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'weather.dart';

@immutable
class WeatherState {
  final DateTime lastUpdate;
  final AsyncValue<List<WeatherModel>> forecast;
  final AsyncValue<WeatherModel> currentWeather;

  const WeatherState({
    required this.lastUpdate,
    required this.forecast,
    required this.currentWeather,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is WeatherState &&
        other.lastUpdate == lastUpdate &&
        other.forecast == forecast &&
        other.currentWeather == currentWeather;
  }

  @override
  int get hashCode =>
      lastUpdate.hashCode ^ forecast.hashCode ^ currentWeather.hashCode;

  WeatherState copyWith({
    DateTime? lastUpdate,
    AsyncValue<List<WeatherModel>>? forecast,
    AsyncValue<WeatherModel>? currentWeather,
  }) {
    return WeatherState(
      lastUpdate: lastUpdate ?? this.lastUpdate,
      forecast: forecast ?? this.forecast,
      currentWeather: currentWeather ?? this.currentWeather,
    );
  }
}
