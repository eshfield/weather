import 'package:flutter/material.dart';

import '../../../l10n/gen/app_localizations.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        l10n.footer,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.grey),
      ),
    );
  }
}
