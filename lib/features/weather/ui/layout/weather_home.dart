import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features.dart';

class WeatherHome extends StatelessWidget {
  const WeatherHome({Key? key}) : super(key: key);
  static const routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${AppLocalizations.of(context)?.weatherInLondon}',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.light_mode),
            onPressed: () {
              Navigator.pushNamed(context, ThemeView.routeName);
            },
          ),
        ],
      ),
      body: Consumer(
        builder: (context, ref, _) {
          return RefreshIndicator(
            backgroundColor: Colors.white,
            color: Colors.lightBlue.shade300,
            onRefresh: () async {
              await ref
                  .read(weatherControllerProvider.notifier)
                  .getWeatherData();
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Column(
                children: const [
                  CurrentWeather(),
                  ForecastList(),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.small(
        child: const Icon(
          Icons.map,
          color: Colors.white,
        ),
        onPressed: () =>
            Navigator.pushNamed(context, WeatherMapWebView.routeName),
      ),
    );
  }
}
