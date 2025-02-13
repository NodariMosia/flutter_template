import 'package:flutter/material.dart';

import 'package:flutter_template/src/features/loading/loading_page.dart';

class AppRouter {
  static const String index = '/';

  static Map<String, WidgetBuilder> routes({Key? loaderKey}) {
    return {
      index: (_) => LoadingPage(key: loaderKey),
    };
  }
}
