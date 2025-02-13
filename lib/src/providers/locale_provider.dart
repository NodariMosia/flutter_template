import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_template/src/generated/l10n/app_l10n.dart';
import 'package:flutter_template/src/generated/l10n/app_l10n_en.dart';
import 'package:flutter_template/src/utils/app_helpers.dart';
import 'package:flutter_template/src/utils/app_storage/app_storage.dart';

class LocaleProvider with ChangeNotifier {
  static const String defaultLangCode = 'en';

  static LocaleProvider? _instance;
  static LocaleProvider get instance {
    if (_instance == null) {
      throw StateError('LocaleProvider not initialized, call #init first.');
    }
    return _instance!;
  }

  late String _langCode;
  late Locale _locale;

  LocaleProvider._() {
    if (!AppStorage.langCode.has()) {
      AppStorage.langCode.set(defaultLangCode);
    }

    _langCode = AppStorage.langCode.get(defaultValue: defaultLangCode)!;
    _locale = Locale(_langCode);
  }

  factory LocaleProvider.init() {
    _instance ??= LocaleProvider._();
    return _instance!;
  }

  String get langCode => _langCode;
  Locale get locale => _locale;
  AppL10n get l10n => AppHelpers.tryGet(() => lookupAppL10n(_locale), AppL10nEn.new);

  void switchLocale(String newLangCode) {
    if (!AppL10n.delegate.isSupported(Locale(newLangCode))) {
      newLangCode = defaultLangCode;
    }

    if (newLangCode == _langCode) {
      return;
    }

    _langCode = newLangCode;
    _locale = Locale(_langCode);
    AppStorage.langCode.set(_langCode);

    notifyListeners();
  }

  void print() => log(toString());

  @override
  String toString() => 'LocaleProvider({ langCode: $langCode, locale: $locale })';
}
