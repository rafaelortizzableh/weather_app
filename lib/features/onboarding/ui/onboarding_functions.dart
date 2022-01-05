part of 'onboarding_screen.dart';

Future<bool> _showLocationNeededDialog({
  required BuildContext context,
  required AppLocalizations? l10n,
  required LocationService locationService,
}) async {
  bool locationEnabled = await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Text('${l10n?.locationServicesNeeded}'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text('${l10n?.close}')),
          TextButton(
              onPressed: () async {
                final couldOpen = await locationService.requestService();
                return Navigator.pop(context, couldOpen);
              },
              child: Text('${l10n?.enableLocationService}')),
        ],
      );
    },
  );
  if (locationEnabled) {
    return await locationService.locationEnabled();
  }
  return locationEnabled;
}

Future<LocationPermission> _requestLocation({
  required BuildContext context,
  required AppLocalizations? l10n,
  required LocationService locationService,
}) async {
  var permissionCheck = await locationService.checkPermission();
  if (permissionCheck != LocationPermission.always ||
      permissionCheck != LocationPermission.whileInUse) {
    permissionCheck = await locationService.requestPermission();
  }
  return permissionCheck;
}

void _showPermissionDeniedDialog({
  required BuildContext context,
  required AppLocalizations? l10n,
}) {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('${l10n?.userDidNotGrantLocationPermissions}'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text('${l10n?.close}')),
          ],
        );
      });
}

Future<void> _setOnboardingComplete(
    {required OnboardingController onboardingController}) async {
  await onboardingController.setOnboardingAsDone();
}

Future<void> _checkIfEnabledAndRequestPermission({
  required WidgetRef ref,
  required BuildContext context,
  required AppLocalizations? l10n,
}) async {
  final locationService = ref.read(locationServiceProvider);
  final onboardingController = ref.read(onboardingControllerProvider.notifier);
  var enabled = await locationService.locationEnabled();
  if (enabled != true) {
    enabled = await _showLocationNeededDialog(
        context: context, l10n: l10n, locationService: locationService);
  } else {
    var permission = await _requestLocation(
        context: context, l10n: l10n, locationService: locationService);
    switch (permission) {
      case LocationPermission.deniedForever:
        _showPermissionDeniedDialog(context: context, l10n: l10n);
        break;
      case LocationPermission.always:
        await _setOnboardingComplete(
            onboardingController: onboardingController);
        break;
      case LocationPermission.whileInUse:
        await _setOnboardingComplete(
            onboardingController: onboardingController);
        break;
      case LocationPermission.denied:
        permission = await _requestLocation(
            context: context, l10n: l10n, locationService: locationService);
        break;
    }
  }
}
