import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../features/features.dart';
import '../../../core/core.dart';

class HomeWrapper extends ConsumerWidget {
  const HomeWrapper({Key? key}) : super(key: key);
  static const routeName = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onboardingComplete = ref.watch(onboardingControllerProvider);

    return FutureBuilder<bool>(
        future: ref.read(locationServiceProvider).locationEnabled(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            );
          }
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text(snapshot.error.toString()),
              ),
            );
          }
          var locationEnabled = snapshot.data == true;

          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            if (locationEnabled == true && !onboardingComplete) {
              return const OnboardingScreen();
            } else if (locationEnabled != true && onboardingComplete) {
              return const EnableLocationRequest();
            } else {
              return const WeatherHome();
            }
          }
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          );
        });
  }
}

class EnableLocationRequest extends StatelessWidget {
  const EnableLocationRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
          child: SizedBox(
        height: size.height / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('👋 ${l10n?.hello}', style: theme.textTheme.headline2),
            Text('${l10n?.locationServicesNeeded}',
                style: theme.textTheme.headline6),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                return ElevatedButton.icon(
                  onPressed: () async => await _showLocationNeededDialog(
                      context: context,
                      l10n: l10n,
                      locationService: ref.read(locationServiceProvider)),
                  label: Text(
                    '${l10n?.requestPermission}',
                    style: theme.textTheme.button?.copyWith(
                      color: theme.colorScheme.secondary,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                  ),
                  icon: Icon(Icons.location_on_sharp,
                      color: theme.colorScheme.secondary),
                );
              },
            ),
          ],
        ),
      )),
    );
  }
}

Future<void> _showLocationNeededDialog({
  required BuildContext context,
  required AppLocalizations? l10n,
  required LocationService locationService,
}) async {
  final settingsOpened = await showDialog(
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
  if (settingsOpened) {
    await locationService.locationEnabled();
  }
}
