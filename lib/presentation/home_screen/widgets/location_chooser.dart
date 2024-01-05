import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/blocs.dart';
import '../../../utils/localization_extension.dart';

class LocationChooser extends StatelessWidget {
  const LocationChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        final locale = Localizations.localeOf(context);
        return SearchAnchor.bar(
          barHintText: state is LocationAcquireSuccess
              ? state.location.getLocationName(locale)
              : '',
          barTrailing: [
            state is LocationAcquireInProgress
                ? const ProgressIndicator()
                : IconButton(
                    icon: const Icon(Icons.location_searching_outlined),
                    onPressed: () =>
                        context.read<LocationCubit>().acquireLocation(),
                  ),
          ],
          isFullScreen: false,
          viewConstraints: const BoxConstraints(maxHeight: 340),
          suggestionsBuilder: suggestionsBuilder,
          textCapitalization: TextCapitalization.words,
          viewHintText: context.l10n.searchHint,
        );
      },
    );
  }

  Iterable<Widget> suggestionsBuilder(
    BuildContext context,
    SearchController controller,
  ) {
    final locale = Localizations.localeOf(context);
    if (controller.text.isEmpty) return [];
    // TODO move this code to the viewOnChanged when this PR comes to stable
    // https://github.com/flutter/flutter/pull/136840
    context
        .read<LocationSearchBloc>()
        .add(LocationSearchRequested(query: controller.text));
    return [
      BlocBuilder<LocationSearchBloc, LocationSearchState>(
        builder: (context, state) {
          if (state is LocationSearchInProgress) {
            return const LinearProgressIndicator();
          } else if (state is LocationSearchFailure) {
            return Center(child: Text(context.l10n.locationSearchError));
          } else if (state is LocationSearchSuccess) {
            if (state.locations.isEmpty) {
              return Center(child: Text(context.l10n.nothingFound));
            }
            return Column(
              children: state.locations.map((location) {
                return ListTile(
                  shape:
                      Border(bottom: BorderSide(color: Colors.grey.shade400)),
                  title: Text(location.getLocationName(locale)),
                  onTap: () async {
                    await context.read<LocationCubit>().setLocation(location);
                    controller.clear();
                    controller.closeView(null);
                    if (context.mounted) FocusScope.of(context).unfocus();
                  },
                );
              }).toList(),
            );
          }
          return const SizedBox.shrink();
        },
      )
    ];
  }
}

class ProgressIndicator extends StatelessWidget {
  const ProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 48,
      height: 48,
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
