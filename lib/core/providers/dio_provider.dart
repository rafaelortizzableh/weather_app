import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dioProvider = Provider<Dio>((ref) =>
    Dio(BaseOptions(baseUrl: 'https://api.openweathermap.org/data/2.5/')));
