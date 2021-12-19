import 'dart:convert';

import 'package:weather_app/features/weather/model/weather_model_entity.dart';

class WeatherModel {
  final String status;
  final double celsiusTemperature;
  final int humidity;
  final double highestTemperature;
  final double lowestTemperature;
  final String iconUrlSmall;
  final String iconUrlLarge;

  WeatherModel({
    required this.status,
    required this.celsiusTemperature,
    required this.humidity,
    required this.highestTemperature,
    required this.lowestTemperature,
    required this.iconUrlSmall,
    required this.iconUrlLarge,
  });

  @override
  String toString() {
    return 'WeatherModel(status: $status, celsiusTemperature: $celsiusTemperature, humidity: $humidity, highestTemperature: $highestTemperature, lowestTemperature: $lowestTemperature, iconUrl: $iconUrlSmall)';
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'celsiusTemperature': celsiusTemperature,
      'humidity': humidity,
      'highestTemperature': highestTemperature,
      'lowestTemperature': lowestTemperature,
      'iconUrl': iconUrlSmall,
    };
  }

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      status: map['status'] ?? '',
      celsiusTemperature: map['celsiusTemperature']?.toDouble() ?? 0.0,
      humidity: map['humidity']?.toDouble() ?? 0,
      highestTemperature: map['highestTemperature']?.toDouble() ?? 0.0,
      lowestTemperature: map['lowestTemperature']?.toDouble() ?? 0.0,
      iconUrlSmall: map['iconUrlSmall'] ?? '',
      iconUrlLarge: map['iconUrlLarge'] ?? '',
    );
  }
  factory WeatherModel.fromEntity(WeatherModelEntity entity) {
    return WeatherModel(
      status: entity.weatherEntity.first.main,
      celsiusTemperature: entity.main.temp,
      humidity: entity.main.humidity,
      highestTemperature: entity.main.tempMax,
      lowestTemperature: entity.main.tempMin,
      iconUrlSmall:
          'https://openweathermap.org/img/wn/${entity.weatherEntity.first.icon}@2x.png',
      iconUrlLarge:
          'https://openweathermap.org/img/wn/${entity.weatherEntity.first.icon}@4x.png',
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));
}
