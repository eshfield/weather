import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/blocs.dart';
import '../../../utils/localization_extension.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.loadingError,
          style: Theme.of(context).textTheme.titleLarge,
          textAlign: TextAlign.center,
        ),
        Text(
          context.l10n.loadingErrorText,
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
