import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/blocs/blocs.dart';
import '../../utils/localization_extension.dart';
import 'widgets/error_snack_bar.dart';
import 'widgets/error_view.dart';
import 'widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<LocationCubit, LocationState>(
            listenWhen: (_, state) => state is LocationAcquireFailure,
            listener: (context, _) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(ErrorSnackBar(context.l10n.locatingError));
            },
          ),
          BlocListener<ForecastCubit, ForecastState>(
            listenWhen: (_, state) => state is ForecastLoadFailure,
            listener: (context, _) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(ErrorSnackBar(context.l10n.loadingError));
            },
          ),
        ],
        child: const SafeArea(child: HomeLayout()),
      ),
    );
  }
}

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const LocationChooser(),
          const SizedBox(height: 32),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return RefreshIndicator(
                  onRefresh: () => context
                      .read<ForecastCubit>()
                      .loadForecast(shouldHideProgress: true),
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: const Content(),
                    ),
                  ),
                );
              },
            ),
          ),
          const LanguageChooser(),
          const Footer(),
        ],
      ),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForecastCubit, ForecastState>(
      builder: (context, state) {
        if (state is ForecastLoadInProgress) {
          if (state.shouldHideProgress) return const SizedBox.expand();
          return const Center(child: CircularProgressIndicator());
        } else if (state is ForecastLoadInitial ||
            state is ForecastLoadFailure) {
          return const ErrorView();
        }
        final forecast = (state as ForecastLoadSuccess).forecast;
        return Column(
          children: [
            CurrentWeather(forecast.currentWeather),
            const SizedBox(height: 32),
            HourlyForecast(forecast.hourlyForecast),
            const SizedBox(height: 32),
            DailyForecast(forecast.dailyForecast),
          ],
        );
      },
    );
  }
}
