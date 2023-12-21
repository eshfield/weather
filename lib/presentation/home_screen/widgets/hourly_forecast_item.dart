import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../domain/models/models.dart';

class HourlyForecastItem extends StatelessWidget {
  final Weather weather;

  const HourlyForecastItem(this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    final dt = DateTime.fromMillisecondsSinceEpoch(weather.timestamp * 1000);
    final locale = Localizations.localeOf(context);
    final formatter =
        locale.languageCode == 'en' ? DateFormat.j() : DateFormat.H();
    return Column(
      children: [
        Text(formatter.format(dt)),
        SvgPicture.asset(
          width: 40,
          height: 40,
          weather.iconPath,
        ),
        Text(
          '${weather.temperature.round()}°',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ],
    );
  }
}
