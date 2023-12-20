import 'package:path/path.dart' as path;
import 'package:json_annotation/json_annotation.dart';

part 'weather_dto.g.dart';

const weatherConditionImagesPath = 'assets/weather_icons';

@JsonSerializable()
class HourlyWeatherDto {
  @JsonKey(name: 'dt')
  final int timestamp;

  @JsonKey(name: 'temp')
  final double temperature;

  @JsonKey(name: 'feels_like')
  final double feelsLike;

  @JsonKey(name: 'weather')
  final List<WeatherConditionDto> descriptions;

  HourlyWeatherDto({
    required this.timestamp,
    required this.temperature,
    required this.feelsLike,
    required this.descriptions,
  });

  factory HourlyWeatherDto.fromJson(Map<String, dynamic> json) =>
      _$HourlyWeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HourlyWeatherDtoToJson(this);
}

// differs from HourlyWeatherDto in 'temp' and 'feels_like' fields types
@JsonSerializable()
class DailyWeatherDto {
  @JsonKey(name: 'dt')
  final int timestamp;

  @JsonKey(name: 'temp')
  final TemperatureDto temperature;

  @JsonKey(name: 'feels_like')
  final FeelsLikeDto feelsLike;

  @JsonKey(name: 'weather')
  final List<WeatherConditionDto> descriptions;

  DailyWeatherDto({
    required this.timestamp,
    required this.temperature,
    required this.feelsLike,
    required this.descriptions,
  });

  factory DailyWeatherDto.fromJson(Map<String, dynamic> json) =>
      _$DailyWeatherDtoFromJson(json);

  Map<String, dynamic> toJson() => _$DailyWeatherDtoToJson(this);
}

@JsonSerializable()
class TemperatureDto {
  final double day;

  TemperatureDto({required this.day});

  factory TemperatureDto.fromJson(Map<String, dynamic> json) =>
      _$TemperatureDtoFromJson(json);
}

@JsonSerializable()
class FeelsLikeDto {
  final double day;

  FeelsLikeDto({required this.day});

  factory FeelsLikeDto.fromJson(Map<String, dynamic> json) =>
      _$FeelsLikeDtoFromJson(json);
}

@JsonSerializable()
class WeatherConditionDto {
  @JsonKey(name: 'id')
  final int conditionId;

  final String description;

  WeatherConditionDto({
    required this.conditionId,
    required this.description,
  });

  factory WeatherConditionDto.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionDtoFromJson(json);
}

String getIconPath(int conditionId) {
  // https://openweathermap.org/weather-conditions
  final conditionGroup = conditionId ~/ 100;
  final name = switch (conditionGroup) {
    2 => 'thunderstorm',
    3 => 'drizzle',
    5 => 'rain',
    6 => 'snow',
    7 => 'atmosphere',
    8 => switch (conditionId) {
        800 => 'clear',
        801 => 'clouds_few',
        _ => 'clouds_overcast',
      },
    _ => 'unknown',
  };
  final filepath = path.join(weatherConditionImagesPath, '$name.svg');
  return filepath;
}
