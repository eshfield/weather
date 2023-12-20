// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForecastDto _$ForecastDtoFromJson(Map<String, dynamic> json) => ForecastDto(
      currentWeather:
          HourlyWeatherDto.fromJson(json['current'] as Map<String, dynamic>),
      hourlyForecast: (json['hourly'] as List<dynamic>)
          .map((e) => HourlyWeatherDto.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyForecast: (json['daily'] as List<dynamic>)
          .map((e) => DailyWeatherDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ForecastDtoToJson(ForecastDto instance) =>
    <String, dynamic>{
      'current': instance.currentWeather,
      'hourly': instance.hourlyForecast,
      'daily': instance.dailyForecast,
    };
