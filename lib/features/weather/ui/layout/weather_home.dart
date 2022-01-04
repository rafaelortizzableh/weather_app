import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../features.dart';

class WeatherHome extends ConsumerWidget {
  const WeatherHome({Key? key}) : super(key: key);
  static const routeName = 'home';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<void>(
        future: ref.watch(weatherControllerProvider.notifier).getWeatherData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const WeatherAppContent();
        });
  }
}

class WeatherAppContent extends StatelessWidget {
  const WeatherAppContent({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Consumer(builder: (context, ref, _) {
          var city = ref.watch(weatherControllerProvider).currentWeather.when(
              data: (weather) => weather.place,
              error: (_, __) => '',
              loading: () => '...');
          return Text(
            '${AppLocalizations.of(context)?.weatherInCity}$city',
          );
        }),
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
