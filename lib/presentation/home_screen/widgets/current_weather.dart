import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' show toBeginningOfSentenceCase;

import '../../../domain/models/models.dart';
import '../../../l10n/gen/app_localizations.dart';

class CurrentWeather extends StatelessWidget {
  final Weather weather;

  const CurrentWeather(this.weather, {super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final units = languageCode == 'en' ? 'F' : 'C';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '${weather.temperature.round()}°',
              style: Theme.of(context).textTheme.displayLarge!.copyWith(
                    fontSize: 100,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 32),
              child: Text(
                units,
                style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 50,
                      fontWeight: FontWeight.w200,
                    ),
              ),
            ),
            const SizedBox(width: 16),
            SvgPicture.asset(
              weather.iconPath,
              width: 120,
              height: 120,
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${l10n.feelsLike} ${weather.feelsLike.round()}°',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 300),
              child: Text(
                toBeginningOfSentenceCase(weather.description)!,
                style: Theme.of(context).textTheme.titleLarge,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
