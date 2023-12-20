import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';

import 'data/repositories/api_repository.dart';
import 'data/repositories/local_repository.dart';
import 'domain/blocs/blocs.dart';
import 'presentation/screens/home_screen/home_screen.dart';
import 'theme.dart';

void main() => runApp(const MainApp());

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late final Logger logger;
  late final ApiRepository apiRepository;
  late final LocalRepository localRepository;

  @override
  void initState() {
    super.initState();
    precacheSvgImages();
    logger = Logger();
    apiRepository = ApiRepository();
    localRepository = LocalRepository();
  }

  Future<void> precacheSvgImages() async {
    final assetManifest = await AssetManifest.loadFromAssetBundle(rootBundle);
    final assets = assetManifest.listAssets();
    final svgPaths = assets.where((path) => path.endsWith('.svg'));
    for (final svgPath in svgPaths) {
      final loader = SvgAssetLoader(svgPath);
      await svg.cache
          .putIfAbsent(loader.cacheKey(null), () => loader.loadBytes(null));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return LocaleCubit(localRepository: localRepository);
        }),
        BlocProvider(create: (context) {
          return LocationCubit(
            logger: logger,
            apiRepository: apiRepository,
            localRepository: localRepository,
          );
        }),
        BlocProvider(create: (context) {
          return LocationSearchBloc(
            logger: logger,
            apiRepository: apiRepository,
          );
        }),
        BlocProvider(create: (context) {
          return ForecastCubit(
            logger: logger,
            apiRepository: apiRepository,
            localeCubit: context.read<LocaleCubit>(),
            locationCubit: context.read<LocationCubit>(),
            locationSearchBloc: context.read<LocationSearchBloc>(),
          );
        }),
      ],
      child: BlocBuilder<LocaleCubit, LocaleState>(
        builder: (context, state) {
          return switch (state) {
            LocaleAcquireInProgress() => const SizedBox.shrink(),
            LocaleAcquireSuccess() => MaterialApp(
                home: const HomeScreen(),
                locale: state.locale,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                theme: theme,
                title: 'Flutter Weather App',
              ),
          };
        },
      ),
    );
  }
}
