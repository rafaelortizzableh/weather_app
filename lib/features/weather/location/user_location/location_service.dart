import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

final deviceLocationProvider = Provider<DeviceLocationService>((ref) =>
    LocalLocationService(
        locationRepository: ref.watch(locationRepositoryProvider)));

abstract class DeviceLocationService {
  Future<Result<Failure, Position?>> getUserLocation();
}

class LocalLocationService implements DeviceLocationService {
  final LocationRepository locationRepository;

  LocalLocationService({required this.locationRepository});
  @override
  Future<Result<Failure, Position?>> getUserLocation() async {
    try {
      final lastPosition = await locationRepository.getUserLocation();
      if (lastPosition == null) {
        final failure = Failure(
          message: AppLocalizations.of(
                      AppConstants.navigationKey.currentContext!)
                  ?.userDidNotGrantLocationPermissions ??
              'Location permissions are permanently denied, we cannot request permissions.',
          code: 998,
        );
        return Error(failure);
      }
      return Success(lastPosition);
    } on Failure catch (failure) {
      return Error(failure);
    } catch (e) {
      final failure = Failure(
        message: AppLocalizations.of(AppConstants.navigationKey.currentContext!)
                ?.userDidNotGrantLocationPermissions ??
            'Location permissions are permanently denied, we cannot request permissions.',
        code: 998,
      );
      return Error(failure);
    }
  }
}
