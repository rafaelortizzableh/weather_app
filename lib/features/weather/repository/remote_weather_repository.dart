import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/core.dart';
import '../../features.dart';

final remoteWeatherRepositoryProvider = Provider<RemoteWeatherRepository>(
  (ref) => OpenWeatherRepository(
    dio: ref.watch(dioProvider),
  ),
);

abstract class RemoteWeatherRepository {
  Future<List<WeatherModelEntity>> getLondonFiveDayForecast();
  Future<WeatherModelEntity> getLondonWeather();
}

class OpenWeatherRepository implements RemoteWeatherRepository {
  const OpenWeatherRepository({required this.dio});
  final Dio dio;

  @override
  Future<WeatherModelEntity> getLondonWeather() async {
    try {
      final languageCode =
          Localizations.localeOf(AppConstants.navigationKey.currentContext!)
              .languageCode;

      final response = await dio.get('weather', queryParameters: {
        'q': 'london',
        'appid': AppConstants.apiKey,
        'lang': languageCode,
        'units': 'metric',
      });

      final Map<String, dynamic> json = response.data;

      return WeatherModelEntity.fromMap(json);
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Failure(
          message:
              '${AppLocalizations.of(AppConstants.navigationKey.currentContext!)?.noInternetConnection}',
          exception: e,
          code: 999, // 999 will let us know it is a connection request
        );
      }

      throw Failure(
        message: e.response?.statusMessage ?? 'Something went wrong',
        code: e.response?.statusCode,
      );
    }
  }

  @override
  Future<List<WeatherModelEntity>> getLondonFiveDayForecast() async {
    try {
      final languageCode =
          Localizations.localeOf(AppConstants.navigationKey.currentContext!)
              .languageCode;

      final response = await dio.get('forecast', queryParameters: {
        'q': 'london',
        'appid': AppConstants.apiKey,
        'lang': languageCode,
        'units': 'metric',
      });

      final results = List<dynamic>.from(response.data['list']);

      // As the API has limitations for free plans, we will grab the weather for the same time on the next five days at the same time
      // 24-hour day / three hour interval -> 8 instance will be equivalent to the current time next day
      // Counting from zero (current time), we grab 5 multiples of eight
      // In the last case, we'll have to get the weather for the hours before the current time (five days from now)
      // This is not ideal, but it's a limitation imposed by the chosen API for their free plans

      final dailyResults = [
        results[7],
        results[15],
        results[23],
        results[31],
        results[39],
      ];

      return dailyResults.map((weatherJsonObject) {
        return WeatherModelEntity.fromMap(weatherJsonObject);
      }).toList();
    } on DioError catch (e) {
      if (e.error is SocketException) {
        throw Failure(
          message:
              '${AppLocalizations.of(AppConstants.navigationKey.currentContext!)?.noInternetConnection}',
          exception: e,
          code: 999, // 999 will let us know it is a connection request
        );
      }

      throw Failure(
        message: e.response?.statusMessage ?? 'Something went wrong',
        code: e.response?.statusCode,
      );
    }
  }
}
