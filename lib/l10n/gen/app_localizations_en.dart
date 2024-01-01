import 'app_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([super.locale = 'en']);

  @override
  String get homeTitle => 'Weather';

  @override
  String get searchHint => 'Search for a location';

  @override
  String get unknownLocalName => 'Location name unknown';

  @override
  String get nothingFound => 'Nothing found';

  @override
  String get feelsLike => 'Feels like';

  @override
  String get hourlyForecastLabel => 'Hourly forecast';

  @override
  String get dailyForecastLabel => 'Daily forecast';

  @override
  String get footer => 'Data is provided by the OpenWeather service';

  @override
  String get loadingError => 'Loading data error';

  @override
  String get loadingErrorText => 'Check you internet connection and/or try again later';

  @override
  String get locatingError => 'Getting location error';

  @override
  String get locationSearchError => 'Location search error';
}
