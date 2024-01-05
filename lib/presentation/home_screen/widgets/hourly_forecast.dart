import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../utils/localization_extension.dart';
import 'hourly_forecast_item.dart';

const hourlyForecastItemCount = 12; // up to 47

class HourlyForecast extends StatelessWidget {
  final List<Weather> weathers;

  const HourlyForecast(this.weathers, {super.key});

  @override
  Widget build(BuildContext context) {
    final items = weathers.sublist(1, hourlyForecastItemCount + 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            context.l10n.hourlyForecastLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (_, index) => HourlyForecastItem(items[index]),
                separatorBuilder: (_, __) => const SizedBox(width: 24),
                itemCount: items.length,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
