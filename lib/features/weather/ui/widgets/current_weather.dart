import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/core.dart';
import '../../../features.dart';

class CurrentWeather extends ConsumerWidget {
  const CurrentWeather({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather = ref.watch(weatherControllerProvider).currentWeather;
    return currentWeather.when(
      data: (weatherModel) => WeatherSuccessWidget(weatherModel: weatherModel),
      error: (error, _) => Center(
        child: Text(
          'Error: $error',
          textAlign: TextAlign.center,
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.network(weatherModel.iconUrlLarge, width: 32.0, height: 32.0),
            const SizedBox(width: AppConstants.padding4),
            Text(
              '${weatherModel.celsiusTemperature}',
              style: theme.textTheme.headline1,
            ),
            const SizedBox(width: AppConstants.padding4),
            Text(
              '°C',
              style: theme.textTheme.headline3,
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Chip(
              label: Text('${weatherModel.humidity}'),
              avatar: const CircleAvatar(
                child: Icon(CupertinoIcons.umbrella),
              ),
            ),
            Chip(
              label: Text('${weatherModel.feelsLike}'),
              avatar: const CircleAvatar(
                child: Icon(CupertinoIcons.person_alt_circle),
              ),
            ),
          ],
        )
      ],
    );
  }
}
