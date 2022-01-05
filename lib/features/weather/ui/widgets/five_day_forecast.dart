import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/core.dart';
import '../../../features.dart';

class ForecastList extends ConsumerWidget {
  const ForecastList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final forecast = ref.watch(weatherControllerProvider).forecast;
    return forecast.when(
      data: (forecastList) => ListView.builder(
        itemCount: forecastList.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(AppConstants.padding12),
        itemBuilder: (context, index) {
          final weather = forecastList[index];
          return ForecastListTile(weather: weather);
        },
      ),
      error: (error, _) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}

class ForecastListTile extends StatelessWidget {
  const ForecastListTile({
    Key? key,
    required this.weather,
  }) : super(key: key);

  final WeatherModel weather;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: AppConstants.padding8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.borderRadius),
        color: theme.brightness == Brightness.light
            ? Colors.white
            : theme.canvasColor,
      ),
      child: ListTile(
        trailing: CircleAvatar(
          backgroundColor: theme.colorScheme.primary,
          child: CachedNetworkImage(
            imageUrl: weather.iconUrlSmall,
            errorWidget: (context, _, __) => const Icon(Icons.error),
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                CircularProgressIndicator(value: downloadProgress.progress),
          ),
        ),
        leading: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${weather.celsiusTemperature.round()}°C',
              style: theme.textTheme.subtitle1?.copyWith(
                  color: theme.brightness == Brightness.light
                      ? Palette.grey600
                      : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        title: Text(
          weather.dateText.toCapitalized(),
          style: theme.textTheme.headline6?.copyWith(
              color: theme.brightness == Brightness.light
                  ? Palette.grey600
                  : Colors.white,
              fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          weather.description.toCapitalized(),
          style: theme.textTheme.subtitle1?.copyWith(
            color: theme.brightness == Brightness.light
                ? Palette.grey600
                : Colors.white,
          ),
        ),
      ),
    );
  }
}
