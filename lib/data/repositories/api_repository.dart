import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../domain/models/models.dart';
import '../mappers/location_mapper.dart';
import '../mappers/forecast_mappers.dart';
import '../sources/api_client.dart';

class ApiRepository {
  late final ApiClient apiClient;

  ApiRepository() {
    final dio = Dio();
    dio.options = BaseOptions(connectTimeout: const Duration(seconds: 30));
    dio.interceptors.add(PrettyDioLogger());
    apiClient = ApiClient(dio);
  }

  Future<Forecast> loadForecast({
    required double latitude,
    required double longitude,
    required String language,
    required String units,
  }) async {
    final forecastDto = await apiClient.getForecast(
      latitude: latitude,
      longitude: longitude,
      language: language,
      units: units,
    );
    return forecastDto.toDomain();
  }

  Future<List<Location>> loadLocationsByName({required String query}) async {
    final locationDtos = await apiClient.getLocationsByName(query: query);
    return locationDtos.map((dto) => dto.toDomain()).toList();
  }

  Future<Location> loadLocationByCoordinates({
    required double latitude,
    required double longitude,
  }) async {
    final locationDtos = await apiClient.getLocationByCoordinates(
      latitude: latitude,
      longitude: longitude,
    );
    return locationDtos.first.toDomain();
  }
}
