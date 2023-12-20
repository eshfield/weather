import '../../domain/models/models.dart';
import '../dtos/weather_dto.dart';

extension HourlyWeatherDtoToDomain on HourlyWeatherDto {
  Weather toDomain() {
    final description = descriptions.first;
    return Weather(
      temperature: temperature,
      feelsLike: feelsLike,
      iconPath: getIconPath(description.conditionId),
      description: description.description,
      timestamp: timestamp,
    );
  }
}

extension DailyWeatherDtoToDomain on DailyWeatherDto {
  Weather toDomain() {
    final description = descriptions.first;
    return Weather(
      temperature: temperature.day,
      feelsLike: feelsLike.day,
      iconPath: getIconPath(description.conditionId),
      description: description.description,
      timestamp: timestamp,
    );
  }
}
