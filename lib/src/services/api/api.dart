library;

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_template/src/common_widgets/flushbar/app_flushbar.dart';
import 'package:flutter_template/src/features/auth/login_page.dart';
import 'package:flutter_template/src/models/user/user.dart';
import 'package:flutter_template/src/providers/locale_provider.dart';
import 'package:flutter_template/src/providers/user_provider.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

part '_api_client.dart';
part '_exceptions.dart';
part '_post_request_hook.dart';
part '_user.dart';
part '_utils.dart';

abstract final class FlutterTemplateApi {
  static const String domain = 'localhost:4200';
  static const String host = '$domain/api/';

  static final FlutterTemplateUserApi user = FlutterTemplateUserApi.init();
}
