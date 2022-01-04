import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/core.dart';
import './geomapping_model.dart';

final geoMappingServiceProvider = Provider<GeoMappingService>(
  (ref) => MapboxGeoMappingService(
    dio: ref.watch(geoMappingDioProvider),
  ),
);

abstract class GeoMappingService {
  Future<GeocodingResponse> getGeocodingResponse(Position userPosition);
}

class MapboxGeoMappingService implements GeoMappingService {
  final Dio dio;

  MapboxGeoMappingService({required this.dio});

  @override
  Future<GeocodingResponse> getGeocodingResponse(Position userPosition) async {
    try {
      final response = await dio.get(
          '${userPosition.longitude},${userPosition.latitude}.json?access_token=${AppConstants.geoMappingApiKey}');

      final json = jsonDecode(response.data);

      final geocodingResponse = GeocodingResponse.fromMap(json);

      return geocodingResponse;
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
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }
}
