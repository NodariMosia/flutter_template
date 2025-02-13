import 'package:flutter/material.dart';

abstract final class GlobalConfig {
  static const bool isProduction = bool.fromEnvironment('dart.vm.product');

  static final GlobalKey<ScaffoldMessengerState> appScaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
}
