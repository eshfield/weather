import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../data/repositories/api_repository.dart';
import '../../data/repositories/local_repository.dart';
import '../../data/services/locator.dart';
import '../models/models.dart';

class LocationCubit extends Cubit<LocationState> {
  final Logger logger;
  final ApiRepository apiRepository;
  final LocalRepository localRepository;

  LocationCubit({
    required this.logger,
    required this.apiRepository,
    required this.localRepository,
  }) : super(LocationAcquireInitial()) {
    initLocation();
  }

  Future<void> initLocation() async {
    final location = await localRepository.getLocation();
    location == null ? await acquireLocation() : await setLocation(location);
  }

  Future<void> acquireLocation() async {
    emit(LocationAcquireInProgress());
    try {
      final position = await getPosition();
      final locationInfo = await apiRepository.loadLocationByCoordinates(
        latitude: position.latitude,
        longitude: position.longitude,
      );
      final location = Location(
          latitude: position.latitude,
          longitude: position.longitude,
          originalName: locationInfo.originalName,
          localNames: locationInfo.localNames,
          country: locationInfo.country);
      await setLocation(location);
    } catch (error) {
      logger.w('acquireLocation error: $error');
      emit(LocationAcquireFailure());
    }
  }

  Future<void> setLocation(Location location) async {
    emit(LocationAcquireSuccess(location: location));
    await localRepository.setLocation(location);
  }
}

sealed class LocationState extends Equatable {}

final class LocationAcquireInitial extends LocationState {
  @override
  List<Object?> get props => [];
}

final class LocationAcquireInProgress extends LocationState {
  @override
  List<Object?> get props => [];
}

final class LocationAcquireSuccess extends LocationState {
  final Location location;

  LocationAcquireSuccess({required this.location});

  @override
  List<Object?> get props => [location];
}

final class LocationAcquireFailure extends LocationState {
  @override
  List<Object?> get props => [];
}
