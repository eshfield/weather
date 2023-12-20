// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyWeatherDto _$HourlyWeatherDtoFromJson(Map<String, dynamic> json) =>
    HourlyWeatherDto(
      timestamp: json['dt'] as int,
      temperature: (json['temp'] as num).toDouble(),
      feelsLike: (json['feels_like'] as num).toDouble(),
      descriptions: (json['weather'] as List<dynamic>)
          .map((e) => WeatherConditionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HourlyWeatherDtoToJson(HourlyWeatherDto instance) =>
    <String, dynamic>{
      'dt': instance.timestamp,
      'temp': instance.temperature,
      'feels_like': instance.feelsLike,
      'weather': instance.descriptions,
    };

DailyWeatherDto _$DailyWeatherDtoFromJson(Map<String, dynamic> json) =>
    DailyWeatherDto(
      timestamp: json['dt'] as int,
      temperature:
          TemperatureDto.fromJson(json['temp'] as Map<String, dynamic>),
      feelsLike:
          FeelsLikeDto.fromJson(json['feels_like'] as Map<String, dynamic>),
      descriptions: (json['weather'] as List<dynamic>)
          .map((e) => WeatherConditionDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DailyWeatherDtoToJson(DailyWeatherDto instance) =>
    <String, dynamic>{
      'dt': instance.timestamp,
      'temp': instance.temperature,
      'feels_like': instance.feelsLike,
      'weather': instance.descriptions,
    };

TemperatureDto _$TemperatureDtoFromJson(Map<String, dynamic> json) =>
    TemperatureDto(
      day: (json['day'] as num).toDouble(),
    );

Map<String, dynamic> _$TemperatureDtoToJson(TemperatureDto instance) =>
    <String, dynamic>{
      'day': instance.day,
    };

FeelsLikeDto _$FeelsLikeDtoFromJson(Map<String, dynamic> json) => FeelsLikeDto(
      day: (json['day'] as num).toDouble(),
    );

Map<String, dynamic> _$FeelsLikeDtoToJson(FeelsLikeDto instance) =>
    <String, dynamic>{
      'day': instance.day,
    };

WeatherConditionDto _$WeatherConditionDtoFromJson(Map<String, dynamic> json) =>
    WeatherConditionDto(
      conditionId: json['id'] as int,
      description: json['description'] as String,
    );

Map<String, dynamic> _$WeatherConditionDtoToJson(
        WeatherConditionDto instance) =>
    <String, dynamic>{
      'id': instance.conditionId,
      'description': instance.description,
    };
