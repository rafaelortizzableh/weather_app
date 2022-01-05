import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';

import '../../../../core/core.dart';
import '../../weather.dart';

final locationRepositoryProvider = Provider<UserLocationRepository>(
  (ref) => UserLocationRepository(
    locationService: ref.watch(locationServiceProvider),
    geoMappingService: ref.watch(geoMappingServiceProvider),
  ),
);

abstract class LocationRepository {
  Future<GeocodingResponse> getUserCityRegionAndCountry(Position userPosition);
  Future<Position?> getUserLocation();
}

class UserLocationRepository implements LocationRepository {
  final LocationService locationService;
  final GeoMappingService geoMappingService;

  UserLocationRepository({
    required this.locationService,
    required this.geoMappingService,
  });

  @override
  Future<GeocodingResponse> getUserCityRegionAndCountry(
      Position userPosition) async {
    try {
      return await geoMappingService.getGeocodingResponse(userPosition);
    } on Failure catch (_) {
      rethrow;
    } catch (error) {
      throw Failure(
        message: 'Could not fetch user location',
        code:
            998, // 998 will let us know that the user's location could not be fetched.
      );
    }
  }

  @override
  Future<Position?> getUserLocation() async {
    try {
      final locationServicesActive = await locationService.checkPermission();
      switch (locationServicesActive) {
        case LocationPermission.always:
          return await locationService.getLocation();
        case LocationPermission.whileInUse:
          return await locationService.getLocation();
        case LocationPermission.deniedForever:
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
        default:
          return Future.error(
              'Location permissions are permanently denied, we cannot request permissions.');
      }
    } on Failure catch (_) {
      rethrow;
    }
  }
}
