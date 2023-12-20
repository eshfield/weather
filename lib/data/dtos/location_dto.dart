import 'package:json_annotation/json_annotation.dart';

part 'location_dto.g.dart';

@JsonSerializable()
class LocationDto {
  @JsonKey(name: 'lat')
  final double latitude;

  @JsonKey(name: 'lon')
  final double longitude;

  @JsonKey(name: 'name')
  final String originalName;

  @JsonKey(name: 'local_names')
  final Map<String, String>? localNames;

  final String country;

  LocationDto({
    required this.latitude,
    required this.longitude,
    required this.originalName,
    required this.localNames,
    required this.country,
  });

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}
