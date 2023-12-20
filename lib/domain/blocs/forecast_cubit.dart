import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

import '../../data/repositories/api_repository.dart';
import '../models/models.dart';
import 'blocs.dart';

class ForecastCubit extends Cubit<ForecastState> {
  final Logger logger;

  final ApiRepository apiRepository;
  final LocaleCubit localeCubit;
  final LocationCubit locationCubit;
  final LocationSearchBloc locationSearchBloc;
  late final StreamSubscription localeCubitSubscription;
  late final StreamSubscription locationCubitSubscription;

  ForecastCubit({
    required this.logger,
    required this.apiRepository,
    required this.localeCubit,
    required this.locationCubit,
    required this.locationSearchBloc,
  }) : super(ForecastLoadInitial()) {
    localeCubitSubscription = localeCubit.stream.listen(
      (localeState) {
        if (localeState is LocaleAcquireSuccess) loadForecast();
      },
    );
    locationCubitSubscription = locationCubit.stream.listen(
      (locationState) {
        if (locationState is LocationAcquireSuccess) loadForecast();
      },
    );
  }

  Future<void> loadForecast({shouldHideProgress = false}) async {
    if (localeCubit.state is LocaleAcquireSuccess &&
        locationCubit.state is LocationAcquireSuccess) {
      emit(ForecastLoadInProgress(shouldHideProgress));
      final locale = (localeCubit.state as LocaleAcquireSuccess).locale;
      final location = (locationCubit.state as LocationAcquireSuccess).location;
      final language = locale.languageCode;
      final units = language == 'en' ? 'imperial' : 'metric';
      try {
        final forecast = await apiRepository.loadForecast(
          latitude: location.latitude,
          longitude: location.longitude,
          language: language,
          units: units,
        );
        emit(ForecastLoadSuccess(forecast: forecast));
      } catch (error) {
        logger.w('loadForecast error: $error');
        emit(ForecastLoadFailure());
      }
    }
  }

  @override
  Future<void> close() {
    localeCubitSubscription.cancel();
    locationCubitSubscription.cancel();
    return super.close();
  }
}

sealed class ForecastState extends Equatable {}

final class ForecastLoadInitial extends ForecastState {
  @override
  List<Object?> get props => [];
}

final class ForecastLoadInProgress extends ForecastState {
  final bool shouldHideProgress;

  ForecastLoadInProgress(this.shouldHideProgress);

  @override
  List<Object?> get props => [];
}

final class ForecastLoadSuccess extends ForecastState {
  final Forecast forecast;

  ForecastLoadSuccess({required this.forecast});

  @override
  List<Object?> get props => [forecast];
}

final class ForecastLoadFailure extends ForecastState {
  @override
  List<Object?> get props => [];
}
