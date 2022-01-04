import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final weatherDioProvider = Provider<Dio>((ref) =>
    Dio(BaseOptions(baseUrl: 'https://api.openweathermap.org/data/2.5/')));

final geoMappingDioProvider = Provider<Dio>((ref) => Dio(BaseOptions(
    baseUrl: 'https://api.mapbox.com/geocoding/v5/mapbox.places/')));
