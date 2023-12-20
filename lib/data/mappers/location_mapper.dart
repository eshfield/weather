import '../../domain/models/models.dart';
import '../dtos/location_dto.dart';

extension LocationDtoToDomain on LocationDto {
  Location toDomain() {
    return Location(
      latitude: latitude,
      longitude: longitude,
      originalName: originalName,
      localNames: localNames ?? {},
      country: country,
    );
  }
}

extension LocationToDto on Location {
  LocationDto toDto() {
    return LocationDto(
      latitude: latitude,
      longitude: longitude,
      originalName: originalName,
      localNames: localNames,
      country: country,
    );
  }
}
