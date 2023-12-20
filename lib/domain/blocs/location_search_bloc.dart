import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../data/repositories/api_repository.dart';
import '../models/models.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  final Logger logger;
  final ApiRepository apiRepository;

  LocationSearchBloc({
    required this.logger,
    required this.apiRepository,
  }) : super(LocationSearchInitial()) {
    on<LocationSearchRequested>(
      (event, emit) async {
        emit(LocationSearchInProgress());
        try {
          final locations =
              await apiRepository.loadLocationsByName(query: event.query);
          emit(LocationSearchSuccess(locations: locations));
        } catch (error) {
          logger.w('onLocationSearchRequested error: $error');
          emit(LocationSearchFailure());
        }
      },
      transformer: (events, mapper) {
        final debouncedEvents = events
            .whereType<LocationSearchRequested>()
            .debounce(const Duration(seconds: 1));
        final restartableTransformer = restartable<LocationSearchRequested>();
        return restartableTransformer(debouncedEvents, mapper);
      },
    );
  }
}

sealed class LocationSearchEvent {}

final class LocationSearchRequested extends LocationSearchEvent {
  final String query;

  LocationSearchRequested({required this.query});
}

sealed class LocationSearchState extends Equatable {}

final class LocationSearchInitial extends LocationSearchState {
  @override
  List<Object?> get props => [];
}

final class LocationSearchInProgress extends LocationSearchState {
  @override
  List<Object?> get props => [];
}

final class LocationSearchSuccess extends LocationSearchState {
  final List<Location> locations;

  LocationSearchSuccess({required this.locations});

  @override
  List<Object?> get props => [locations];
}

final class LocationSearchFailure extends LocationSearchState {
  @override
  List<Object?> get props => [];
}
