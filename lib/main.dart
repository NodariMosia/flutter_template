import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_template/src/app.dart';
import 'package:flutter_template/src/config/global_config.dart';
import 'package:flutter_template/src/providers/app_theme_provider.dart';
import 'package:flutter_template/src/providers/locale_provider.dart';
import 'package:flutter_template/src/providers/user_provider.dart';
import 'package:flutter_template/src/utils/app_generic_cache.dart';
import 'package:flutter_template/src/utils/app_storage/app_storage.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (GlobalConfig.isProduction) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await AppStorage.init();
  AppGenericCache.init();

  UserProvider.init().print();
  LocaleProvider.init().print();
  AppThemeProvider.init().print();
  AppStorage.print();

  runApp(const FlutterTemplateApp());
}
