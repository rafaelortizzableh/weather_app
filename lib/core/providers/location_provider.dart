import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/location_service.dart';

/// Location Service Riverpod Provider
final locationServiceProvider =
    Provider<LocationService>((ref) => LocationService());
