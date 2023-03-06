import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_temp/generated/l10n.dart';
import 'package:flutter_temp/network/app_api.dart';
import 'package:flutter_temp/repositories/fit_repository.dart';

import '../common/app_themes.dart';
import '../network/api_util.dart';
import '../page/splash/splash_page.dart';
import 'app_cubit.dart';

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  late final AppApi _apiClient;

  @override
  void initState() {
    _apiClient = ApiUtil.instance.apiClient;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FitRepository>(create: (context) {
          return FitRepositoryImpl(_apiClient);
        }),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AppCubit>(create: (context) {
            return AppCubit();
          }),
        ],
        child: BlocBuilder<AppCubit, AppState>(
          buildWhen: (pre, cur) => pre.themeMode != cur.themeMode || pre.locale != cur.locale,
          builder: (context, state) {
            return MaterialApp(
              /// Theme
              theme: lightTheme,
              //darkTheme: darkTheme,
              //themeMode: state.themeMode,
              /// Localization stuff
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                S.delegate,
              ],
              supportedLocales: S.delegate.supportedLocales,
              locale: state.locale,
              debugShowCheckedModeBanner: false,
              home: const SplashPage(),
            );
          },
        ),
      ),
    );
  }
}
