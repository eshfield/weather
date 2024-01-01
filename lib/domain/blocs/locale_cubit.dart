import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/local_repository.dart';
import '../../l10n/gen/app_localizations.dart';

final defaultLocale = basicLocaleListResolution(
  WidgetsBinding.instance.platformDispatcher.locales,
  AppLocalizations.supportedLocales,
);

class LocaleCubit extends Cubit<LocaleState> {
  final LocalRepository localRepository;

  LocaleCubit({required this.localRepository})
      : super(LocaleAcquireInProgress()) {
    initLocale();
  }

  Future<void> initLocale() async {
    final locale = await localRepository.getLocale(defaultLocale);
    emit(LocaleAcquireSuccess(locale: locale ?? defaultLocale));
  }

  Future<void> setLocale(Locale locale) async {
    emit(LocaleAcquireSuccess(locale: locale));
    await localRepository.setLocale(locale);
  }
}

sealed class LocaleState extends Equatable {}

final class LocaleAcquireInProgress extends LocaleState {
  @override
  List<Object?> get props => [];
}

final class LocaleAcquireSuccess extends LocaleState {
  final Locale locale;

  LocaleAcquireSuccess({required this.locale});

  @override
  List<Object?> get props => [locale];
}
