import 'app_localizations.dart';

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([super.locale = 'ru']);

  @override
  String get homeTitle => 'Погода';

  @override
  String get searchHint => 'Поиск местоположения';

  @override
  String get unknownLocalName => 'Название места неизвестно';

  @override
  String get nothingFound => 'Ничего не найдено';

  @override
  String get feelsLike => 'Ощущается как';

  @override
  String get hourlyForecastLabel => 'Прогноз по часам';

  @override
  String get dailyForecastLabel => 'Прогноз по дням';

  @override
  String get footer => 'Данные предоставлены сервисом OpenWeather';

  @override
  String get loadingError => 'Ошибка загрузки данных';

  @override
  String get loadingErrorText => 'Проверьте интернет-соединение и/или попробуйте ещё раз';

  @override
  String get locatingError => 'Ошибка определения местоположения';

  @override
  String get locationSearchError => 'Ошибка поиска местоположения';
}
