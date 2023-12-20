import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../dtos/forecast_dto.dart';
import '../dtos/location_dto.dart';

part 'api_client.g.dart';

class Api {
  static const apiKey = String.fromEnvironment('api-key');
  static const baseUrl = 'https://api.openweathermap.org/';
  static const excludeFields = 'minutely,alerts';
  static const oneCall = 'data/3.0/onecall';
  static const geo = 'geo/1.0';
  static const geoDirect = '$geo/direct';
  static const geoReverse = '$geo/reverse';
}

@RestApi(baseUrl: Api.baseUrl)
abstract class ApiClient {
  factory ApiClient(Dio dio) = _ApiClient;

  @GET(Api.oneCall)
  Future<ForecastDto> getForecast({
    @Query('lat') required double latitude,
    @Query('lon') required double longitude,
    @Query('lang') required String language,
    @Query('units') required String units,
    @Query('exclude') String exclude = Api.excludeFields,
    @Query('appid') String apiKey = Api.apiKey,
  });

  @GET(Api.geoDirect)
  Future<List<LocationDto>> getLocationsByName({
    @Query('q') required String query,
    @Query('limit') int limit = 5,
    @Query('appid') String apiKey = Api.apiKey,
  });

  @GET(Api.geoReverse)
  Future<List<LocationDto>> getLocationByCoordinates({
    @Query('lat') required double latitude,
    @Query('lon') required double longitude,
    @Query('limit') int limit = 1,
    @Query('appid') String apiKey = Api.apiKey,
  });
}
