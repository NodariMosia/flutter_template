import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_template/src/theme/app_theme.dart';
import 'package:flutter_template/src/utils/app_storage/app_storage.dart';

class AppThemeProvider with ChangeNotifier {
  static const ThemeMode defaultThemeMode = ThemeMode.system;

  static final SystemUiOverlayStyle _lightSystemUiOverlayStyle = SystemUiOverlayStyle.dark.copyWith(
    systemNavigationBarColor: Colors.white,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  static final SystemUiOverlayStyle _darkSystemUiOverlayStyle = SystemUiOverlayStyle.light.copyWith(
    systemNavigationBarColor: AppColors.greyBlue[900]!,
    systemNavigationBarIconBrightness: Brightness.light,
  );

  static AppThemeProvider? _instance;
  static AppThemeProvider get instance {
    if (_instance == null) {
      throw StateError('AppThemeProvider not initialized, call #init first.');
    }
    return _instance!;
  }

  late ThemeMode _themeMode;

  AppThemeProvider._() {
    if (!AppStorage.themeMode.has()) {
      AppStorage.themeMode.set(defaultThemeMode);
    }

    _themeMode = AppStorage.themeMode.get(defaultValue: defaultThemeMode)!;

    setSystemNavigationBarTheme();

    PlatformDispatcher.instance.onPlatformBrightnessChanged = () {
      if (_themeMode == ThemeMode.system) {
        setSystemNavigationBarTheme();
      }
    };
  }

  factory AppThemeProvider.init() {
    _instance ??= AppThemeProvider._();
    return _instance!;
  }

  ThemeMode get themeMode => _themeMode;
  Brightness get brightness => switch (_themeMode) {
        ThemeMode.dark => Brightness.dark,
        ThemeMode.light => Brightness.light,
        ThemeMode.system => PlatformDispatcher.instance.platformBrightness,
      };

  void switchTheme(ThemeMode newThemeMode) {
    if (newThemeMode == _themeMode) {
      return;
    }

    _themeMode = newThemeMode;
    AppStorage.themeMode.set(_themeMode);

    setSystemNavigationBarTheme();

    notifyListeners();
  }

  void setSystemNavigationBarTheme() {
    SystemChrome.setSystemUIOverlayStyle(
      brightness == Brightness.light ? _lightSystemUiOverlayStyle : _darkSystemUiOverlayStyle,
    );
  }

  void print() => log(toString());

  @override
  String toString() => 'AppThemeProvider({ themeMode: $themeMode, brightness: $brightness })';
}
