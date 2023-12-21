import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/blocs/blocs.dart';

class LanguageChooser extends StatelessWidget {
  const LanguageChooser({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        languageButton(
          context,
          languageCode: 'en',
          title: 'English',
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('|', style: TextStyle(color: Colors.grey)),
        ),
        languageButton(
          context,
          languageCode: 'ru',
          title: 'Русский',
        ),
      ],
    );
  }

  Widget languageButton(
    BuildContext context, {
    required String languageCode,
    required String title,
  }) {
    final currentLocale = Localizations.localeOf(context);
    return TextButton(
      onPressed: currentLocale.languageCode == languageCode
          ? null
          : () {
              final locale = Locale(languageCode);
              context.read<LocaleCubit>().setLocale(locale);
            },
      child: Text(title),
    );
  }
}
