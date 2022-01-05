import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final currentWeather = ref.watch(weatherControllerProvider).currentWeather;
    return currentWeather.when(
      data: (weatherModel) => WeatherSuccessWidget(weatherModel: weatherModel),
      error: (error, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Error: $error',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppConstants.padding12),
            ElevatedButton(
                style: theme.brightness == Brightness.dark
                    ? null
                    : ElevatedButton.styleFrom(
                        primary: Colors.white,
                      ),
                onPressed: () {
                  ref
                      .read(weatherControllerProvider.notifier)
                      .getWeatherData(isReload: false);
                },
                child: Text('${AppLocalizations.of(context)?.reloadWeather}')),
          ],
        ),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}

class WeatherSuccessWidget extends StatelessWidget {
  const WeatherSuccessWidget({Key? key, required this.weatherModel})
      : super(key: key);
  final WeatherModel weatherModel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${weatherModel.celsiusTemperature.round()}',
                          style: theme.textTheme.headline1),
                      Padding(
                        padding:
                            const EdgeInsets.only(top: AppConstants.padding12),
                        child: Text(
                          '°C',
                          style: theme.textTheme.headline4
                              ?.copyWith(fontWeight: FontWeight.w200),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: AppConstants.padding4),
                  CachedNetworkImage(
                    imageUrl: weatherModel.iconUrlLarge,
                    width: 128.0,
                    height: 128.0,
                    errorWidget: (context, _, __) => const Icon(Icons.error),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            CircularProgressIndicator(
                                value: downloadProgress.progress),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppConstants.padding8),
          Text(weatherModel.description.toCapitalized(),
              style: theme.textTheme.headline4
                  ?.copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.start),
          const SizedBox(height: AppConstants.padding8),
          Text(weatherModel.dateText.toCapitalized(),
              style: theme.textTheme.headline5
                  ?.copyWith(fontWeight: FontWeight.w300),
              textAlign: TextAlign.start),
          const SizedBox(height: AppConstants.padding8),
          Wrap(
            alignment: WrapAlignment.spaceAround,
            spacing: AppConstants.padding8,
            children: [
              DataChip(
                  text: '${weatherModel.humidity}%',
                  icon: CupertinoIcons.drop_fill,
                  theme: theme),
              DataChip(
                text: '${weatherModel.feelsLike.round()}°C',
                icon: CupertinoIcons.person_alt_circle,
                theme: theme,
              ),
              DataChip(
                text: '${weatherModel.highestTemperature.round()}°C',
                icon: CupertinoIcons.arrow_up,
                theme: theme,
              ),
              DataChip(
                text: '${weatherModel.lowestTemperature.round()}°C',
                icon: CupertinoIcons.arrow_down,
                theme: theme,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DataChip extends StatelessWidget {
  const DataChip({
    Key? key,
    required this.theme,
    required this.icon,
    required this.text,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Chip(
        backgroundColor: theme.brightness == Brightness.light
            ? Colors.white
            : theme.canvasColor,
        label: Text(
          text,
          style: theme.textTheme.bodyText1?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.brightness == Brightness.light
                ? Palette.grey600
                : Colors.white,
          ),
        ),
        avatar: CircleAvatar(
          child: Icon(icon),
          backgroundColor: theme.brightness == Brightness.light
              ? Palette.grey600
              : Colors.white,
          foregroundColor: theme.brightness == Brightness.light
              ? Colors.white
              : theme.canvasColor,
        ),
      ),
    );
  }
}
