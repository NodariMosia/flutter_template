import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'app_hive_box.dart';
part 'object_stores/app_hive_object_store.dart';
part 'object_stores/lang_code_store.dart';
part 'object_stores/session_id_store.dart';
part 'object_stores/theme_mode_store.dart';
part 'object_stores/user_map_store.dart';

abstract final class AppStorage {
  static const String appHiveBoxName = 'flutter_template_app_cache';

  static Future<void> init() => _AppHiveBox.init(appHiveBoxName);
  static Future<void> clear() => _AppHiveBox.clear();
  static Map<dynamic, dynamic> toMap() => _AppHiveBox.toMap();
  static void print() => _AppHiveBox.print();

  static const LangCodeStore langCode = LangCodeStore._();
  static const SessionIdStore sessionId = SessionIdStore._();
  static const ThemeModeStore themeMode = ThemeModeStore._();
  static const UserMapStore userMap = UserMapStore._();
}
