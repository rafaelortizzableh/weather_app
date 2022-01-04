import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/model/weather_model_entity.dart';

class WeatherModel {
  final String status;
  final double celsiusTemperature;
  final double feelsLike;
  final int humidity;
  final double highestTemperature;
  final double lowestTemperature;
  final String iconUrlSmall;
  final String iconUrlLarge;
  final DateTime timeStamp;
  final String place;

  WeatherModel({
    required this.status,
    required this.celsiusTemperature,
    required this.feelsLike,
    required this.humidity,
    required this.highestTemperature,
    required this.lowestTemperature,
    required this.iconUrlSmall,
    required this.iconUrlLarge,
    required this.timeStamp,
    required this.place,
  });

  WeatherModel.initial()
      : status = '',
        celsiusTemperature = 0,
        feelsLike = 0,
        humidity = 0,
        highestTemperature = 0,
        lowestTemperature = 0,
        iconUrlSmall = '',
        iconUrlLarge = '',
        place = '',
        timeStamp = DateTime.now();

  factory WeatherModel.fromEntity(WeatherModelEntity entity) {
    return WeatherModel(
      status: entity.weatherEntity.first.main,
      celsiusTemperature: entity.main.temp,
      feelsLike: entity.main.feelsLike,
      humidity: entity.main.humidity,
      highestTemperature: entity.main.tempMax,
      lowestTemperature: entity.main.tempMin,
      place: entity.name ?? '',
      timeStamp: DateTime.fromMillisecondsSinceEpoch(entity.dt * 1000),
      iconUrlSmall:
          'https://openweathermap.org/img/wn/${entity.weatherEntity.first.icon}@2x.png',
      iconUrlLarge:
          'https://openweathermap.org/img/wn/${entity.weatherEntity.first.icon}@4x.png',
    );
  }

  String toJson() => json.encode(toMap());

  factory WeatherModel.fromJson(String source) =>
      WeatherModel.fromMap(json.decode(source));

  Map<String, dynamic> toMap() {
    return {
      'status': status,
      'celsiusTemperature': celsiusTemperature,
      'feelsLike': feelsLike,
      'humidity': humidity,
      'highestTemperature': highestTemperature,
      'lowestTemperature': lowestTemperature,
      'iconUrlSmall': iconUrlSmall,
      'iconUrlLarge': iconUrlLarge,
      'timeStamp': timeStamp.toString(),
      'place': place,
    };
  }

  String get dateText => DateFormat('EEEEEE, dd/M/y').format(timeStamp);

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    return WeatherModel(
      place: map['place'] ?? '',
      status: map['status'] ?? '',
      celsiusTemperature: map['celsiusTemperature']?.toDouble() ?? 0.0,
      feelsLike: map['feelsLike']?.toDouble() ?? 0.0,
      humidity: map['humidity']?.toInt() ?? 0,
      highestTemperature: map['highestTemperature']?.toDouble() ?? 0.0,
      lowestTemperature: map['lowestTemperature']?.toDouble() ?? 0.0,
      iconUrlSmall: map['iconUrlSmall'] ?? '',
      iconUrlLarge: map['iconUrlLarge'] ?? '',
      timeStamp: DateTime.parse(map['timeStamp']),
    );
  }
}
