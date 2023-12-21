import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/models.dart';

class DailyForecastItem extends StatelessWidget {
  final Weather weather;

  const DailyForecastItem(this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final dt = DateTime.fromMillisecondsSinceEpoch(weather.timestamp * 1000);
    final locale = Localizations.localeOf(context);
    final formatter = DateFormat.E(locale.toString());

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: 50,
          child: Text(
            formatter.format(dt),
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),
        SizedBox(
          width: 50,
          child: Text(
            '${weather.temperature.round()}°',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        SizedBox(
          width: 140,
          child: Text(
            '${l10n.feelsLike} ${weather.feelsLike.round()}°',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ),
        SvgPicture.asset(
          width: 32,
          height: 32,
          weather.iconPath,
        ),
      ],
    );
  }
}
