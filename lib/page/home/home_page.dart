import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_temp/common/app_colors.dart';
import 'package:flutter_temp/common/app_enums.dart';
import 'package:flutter_temp/common/app_shadows.dart';
import 'package:flutter_temp/main.dart';
import 'package:flutter_temp/page/main/main_page.dart';
import 'package:flutter_temp/page/setting/setting_page.dart';
import 'package:flutter_temp/utils/app_connection.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/app_cubit.dart';
import '../../utils/app_flush_bar.dart';
import 'home_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final AppCubit _appCubit;
  late final HomeCubit _homeCubit;

  late PageController _pageController;

  Map _source = {ConnectivityResult.none: false};
  final AppConnection _networkConnectivity = AppConnection.instance;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0, keepPage: true);

    _appCubit = BlocProvider.of<AppCubit>(context);
    _homeCubit = HomeCubit();

    _networkConnectivity.initialise();

    _networkConnectivity.myStream.listen((source) {
      _source = source;
      logger.i('source $_source');
      switch (_source.keys.toList()[0]) {
        case ConnectivityResult.mobile:
          _appCubit.setConnectionStatus(_source.values.toList()[0]
              ? ConnectionStatus.mobileOnline
              : ConnectionStatus.mobileOffline);
          break;
        case ConnectivityResult.wifi:
          _appCubit.setConnectionStatus(_source.values.toList()[0]
              ? ConnectionStatus.wifiOnline
              : ConnectionStatus.wifiOffline);
          break;
        case ConnectivityResult.none:
        default:
          _appCubit.setConnectionStatus(ConnectionStatus.offline);
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<AppCubit, AppState>(
        bloc: _appCubit,
        listener: (context, state) => onConnectionChangedListener(state.connectionStatus),
        listenWhen: (pre, cur) => pre.connectionStatus != cur.connectionStatus,
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: BlocListener<HomeCubit, HomeState>(
            bloc: _homeCubit,
            listenWhen: (pre, cur) => pre.currentIndex != cur.currentIndex,
            listener: (context, state) {
              _pageController.jumpToPage(state.currentIndex);
            },
            child: PageView(
              controller: _pageController,
              children: const [
                MainPage(),
                SettingPage(),
              ],
            ),
          ),
          bottomNavigationBar: BlocBuilder<HomeCubit, HomeState>(
            bloc: _homeCubit,
            buildWhen: (pre, cur) => pre.currentIndex != cur.currentIndex,
            builder: (context, state) {
              return Container(
                decoration: BoxDecoration(
                  border: const Border(
                    top: BorderSide(color: Colors.black, width: 0),
                  ),
                  boxShadow: AppShadows.bottomNavigationBarShadow,
                ),
                child: BottomNavigationBar(
                  items: _bottomBar,
                  currentIndex: state.currentIndex,
                  onTap: (int index) {
                    _homeCubit.onChangedIndex(index);
                  },
                  elevation: 0,
                  // When set type to shifting => consider set background color for each BottomNavigationBarItem
                  // When set type to fixed => consider set background color at backgroundColor || fixedColor at BottomNavigationBar
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  //fixedColor: Colors.orange.withOpacity(0.6),
                  iconSize: 24,
                  selectedItemColor: AppColors.navActiveItemColor,
                  unselectedItemColor: AppColors.navUnActiveItemColor,
                  selectedFontSize: 16,
                  unselectedFontSize: 14,
                  selectedLabelStyle: GoogleFonts.sourceCodePro(
                    //fontSize: 20, // Override selectedFontSize attribute
                    // color: Colors.white,
                  ),
                  unselectedLabelStyle: GoogleFonts.sourceCodePro(
                    //fontSize: 20, // Override unselectedFontSize attribute
                    //color: Colors.purpleAccent,
                  ),
                  selectedIconTheme: const IconThemeData(
                    color: AppColors.navActiveItemColor, // Override selectedItemColor attribute
                    opacity: 0.8,
                    size: 24, // Override iconSize attribute
                  ),
                  unselectedIconTheme: const IconThemeData(
                    color: AppColors.navUnActiveItemColor, // Override unselectedItemColor attribute
                    opacity: 0.8,
                    size: 24, // Override iconSize attribute
                  ),
                  showUnselectedLabels: true,
                  showSelectedLabels: true,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void onGranted() => logger.i('granted');

  void onDenied() => logger.i('denied');

  void onConnectionChangedListener(ConnectionStatus? connectionStatus) {
    switch (connectionStatus) {
      case ConnectionStatus.mobileOffline:
      case ConnectionStatus.wifiOffline:
      case ConnectionStatus.offline:
        AppFlushBar.showFlushBar(context,
            message: connectionStatus?.message.toString().trim(),
            type: FlushType.error);
        break;
      case ConnectionStatus.mobileOnline:
      case ConnectionStatus.wifiOnline:
        AppFlushBar.showFlushBar(context,
          message: connectionStatus?.message.toString().trim(),
          type: FlushType.notification);
        break;
      default:
        break;
    }
  }

  /// Component Widgets
  List<BottomNavigationBarItem> get _bottomBar => [
        const BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          activeIcon: Icon(Icons.home_rounded),
          backgroundColor: Colors.white, // Will be override if backgroundColor form BottomNavigationBar has been set
          label: 'Home',
          tooltip: 'Home',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.settings_rounded),
          activeIcon: Icon(Icons.settings_rounded),
          backgroundColor: Colors.white,
          label: 'Setting',
          tooltip: 'Setting',
        ),
      ];

  @override
  void dispose() {
    _networkConnectivity.disposeStream();
    _homeCubit.close();
    super.dispose();
  }
}
