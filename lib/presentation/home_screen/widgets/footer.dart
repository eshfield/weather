import 'package:flutter/material.dart';

import '../../../utils/localization_extension.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Text(
        context.l10n.footer,
        style: Theme.of(context)
            .textTheme
            .labelSmall!
            .copyWith(color: Colors.grey),
      ),
    );
  }
}
