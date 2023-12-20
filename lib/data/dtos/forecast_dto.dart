import 'package:json_annotation/json_annotation.dart';

import 'weather_dto.dart';

part 'forecast_dto.g.dart';

@JsonSerializable()
class ForecastDto {
  @JsonKey(name: 'current')
  final HourlyWeatherDto currentWeather;

  @JsonKey(name: 'hourly')
  final List<HourlyWeatherDto> hourlyForecast;

  @JsonKey(name: 'daily')
  final List<DailyWeatherDto> dailyForecast;

  ForecastDto({
    required this.currentWeather,
    required this.hourlyForecast,
    required this.dailyForecast,
  });

  factory ForecastDto.fromJson(Map<String, dynamic> json) =>
      _$ForecastDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ForecastDtoToJson(this);
}
