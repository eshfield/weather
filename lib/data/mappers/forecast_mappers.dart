import 'package:weather/data/mappers/weather_mapper.dart';

import '../../domain/models/models.dart';
import '../dtos/forecast_dto.dart';

extension ForecastDtoToDomain on ForecastDto {
  Forecast toDomain() {
    return Forecast(
      currentWeather: currentWeather.toDomain(),
      hourlyForecast: hourlyForecast.map((dto) => dto.toDomain()).toList(),
      dailyForecast: dailyForecast.map((dto) => dto.toDomain()).toList(),
    );
  }
}
