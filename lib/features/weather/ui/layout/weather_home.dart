import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../features.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({Key? key}) : super(key: key);
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          title: Text(
            '${AppLocalizations.of(context)?.weatherInLondon}',
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text('', style: Theme.of(context).textTheme.headline2),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.light_mode),
              onPressed: () {
                Navigator.restorablePushNamed(context, ThemeView.routeName);
              },
            ),
          ],
        ),
        const SliverToBoxAdapter(child: CurrentWeather()),
      ],
    );
  }
}
