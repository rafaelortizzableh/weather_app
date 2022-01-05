import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import '../../../core/core.dart';
import '../../../features/features.dart';

part 'onboarding_functions.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      body: Center(
          child: SizedBox(
        height: size.height / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('👋 ${l10n?.hello}', style: theme.textTheme.headline2),
            Text(
              '${l10n?.permissionNeeded}',
              style: theme.textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Consumer(
              builder: (BuildContext context, WidgetRef ref, _) {
                return ElevatedButton.icon(
                  onPressed: () async =>
                      await _checkIfEnabledAndRequestPermission(
                          context: context, l10n: l10n, ref: ref),
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
