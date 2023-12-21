import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../domain/blocs/blocs.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          l10n.loadingError,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        Text(
          l10n.loadingErrorText,
          textAlign: TextAlign.center,
        ),
        IconButton(
          onPressed: () => context.read<ForecastCubit>().loadForecast(),
          icon: const Icon(
            Icons.replay_rounded,
            size: 48,
          ),
        ),
      ],
    );
  }
}