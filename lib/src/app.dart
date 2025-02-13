import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'package:flutter_template/src/config/global_config.dart';
import 'package:flutter_template/src/generated/l10n/app_l10n.dart';
import 'package:flutter_template/src/providers/app_theme_provider.dart';
import 'package:flutter_template/src/providers/locale_provider.dart';
import 'package:flutter_template/src/providers/user_provider.dart';
import 'package:flutter_template/src/routing/app_router.dart';
import 'package:flutter_template/src/theme/app_theme.dart';

class FlutterTemplateApp extends StatefulWidget {
  const FlutterTemplateApp({super.key});

  @override
  State<FlutterTemplateApp> createState() => _FlutterTemplateAppState();
}

class _FlutterTemplateAppState extends State<FlutterTemplateApp> {
  @override
  void dispose() {
    Hive.close();
    AppThemeProvider.instance.dispose();
    LocaleProvider.instance.dispose();
    UserProvider.instance.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge([
        AppThemeProvider.instance,
        LocaleProvider.instance,
        UserProvider.instance,
      ]),
      builder: (_, __) {
        final String appTitle = LocaleProvider.instance.l10n.appTitle;
        final String snakeCaseAppTitle = appTitle.toLowerCase().split(' ').join('_');

        return MaterialApp(
          title: appTitle,
          restorationScopeId: '${snakeCaseAppTitle}_app',
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: GlobalConfig.appScaffoldMessengerKey,
          theme: AppThemeData.themeData(Brightness.light),
          darkTheme: AppThemeData.themeData(Brightness.dark),
          themeMode: AppThemeProvider.instance.themeMode,
          locale: LocaleProvider.instance.locale,
          supportedLocales: AppL10n.supportedLocales,
          localizationsDelegates: AppL10n.localizationsDelegates,
          initialRoute: '/',
          routes: AppRouter.routes(),
        );
      },
    );
  }
}
