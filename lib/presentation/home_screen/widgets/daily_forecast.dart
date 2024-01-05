import 'package:flutter/material.dart';

import '../../../domain/models/models.dart';
import '../../../utils/localization_extension.dart';
import 'widgets.dart';

const dailyForecastItemCount = 7; // up to 7

class DailyForecast extends StatelessWidget {
  final List<Weather> weathers;

  const DailyForecast(this.weathers, {super.key});

  @override
  Widget build(BuildContext context) {
    final items = weathers.sublist(1, dailyForecastItemCount + 1);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            context.l10n.dailyForecastLabel,
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        Card(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: List.generate(
                items.length,
                (index) => DailyForecastItem(items[index]),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
