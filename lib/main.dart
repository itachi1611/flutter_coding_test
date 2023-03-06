import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_temp/database/app_shared_preference.dart';
import 'package:flutter_temp/utils/app_logger.dart';

import 'app/app_page.dart';

final navigatorKey = GlobalKey<NavigatorState>();
final logger = AppLogger.instance;

Future<void> main() async {
  /// Initialize packages
  WidgetsFlutterBinding.ensureInitialized();

  AppSharedPreference.init();

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.white.withOpacity(0)));

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(const AppPage());
  });
}
