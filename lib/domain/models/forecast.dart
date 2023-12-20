import 'weather.dart';

class Forecast {
  final Weather currentWeather;
  final List<Weather> hourlyForecast;
  final List<Weather> dailyForecast;

  Forecast({
    required this.currentWeather,
    required this.hourlyForecast,
    required this.dailyForecast,
  });
}
