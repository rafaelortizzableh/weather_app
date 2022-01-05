import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:weather_app/core/core.dart';

class LocationService {
  Future<bool> locationEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  Future<LocationPermission> checkPermission() async {
    return await Geolocator.checkPermission();
  }

  Future<LocationPermission> requestPermission() async {
    try {
      return await Geolocator.requestPermission();
    } on PermissionDefinitionsNotFoundException catch (error) {
      throw Failure(
          message: 'Permissions not configured properly', exception: error);
    } on PermissionRequestInProgressException catch (error) {
      throw Failure(
          message: 'Permissions currently being requested', exception: error);
    }
  }

  Future<bool> requestService() async {
    try {
      return await Geolocator.openAppSettings();
    } on PermissionDefinitionsNotFoundException catch (error) {
      throw Failure(message: 'Could not open App Settings', exception: error);
    } on PermissionRequestInProgressException catch (error) {
      throw Failure(message: 'Could not open App Settings', exception: error);
    }
  }

  Future<Position?> getLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
          timeLimit: const Duration(seconds: 2));
      return position;
    } on TimeoutException catch (_) {
      return await Geolocator.getLastKnownPosition();
    } on LocationServiceDisabledException catch (error) {
      throw Failure(
          message: 'Location Services are currently disabled',
          exception: error);
    }
  }
}
