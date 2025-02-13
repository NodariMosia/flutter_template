import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_template/src/features/auth/auth_overview_page.dart';
import 'package:flutter_template/src/features/profile/profile_page.dart';
import 'package:flutter_template/src/models/user/user.dart';
import 'package:flutter_template/src/utils/app_storage/app_storage.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

class UserProvider with ChangeNotifier {
  static UserProvider? _instance;
  static UserProvider get instance {
    if (_instance == null) {
      throw StateError('UserProvider not initialized, call #init first.');
    }
    return _instance!;
  }

  late String? _sessionId;
  late User? _user;

  UserProvider._() {
    final String? sessionId = AppStorage.sessionId.get();
    final Map<String, dynamic>? userMap = AppStorage.userMap.get();

    _sessionId = sessionId.isFalsy ? null : sessionId!;
    _user = userMap.isFalsy ? null : User.fromJson(userMap!);
  }

  factory UserProvider.init() {
    _instance ??= UserProvider._();
    return _instance!;
  }

  String? get sessionId => _sessionId;
  User? get user => _user;
  bool get hasSession => _sessionId.isTruthy;

  void logIn(
    String sessionId,
    User user, {
    bool shouldNotifyListeners = true,
  }) {
    AppStorage.sessionId.set(sessionId);
    AppStorage.userMap.set(user.toJson());
    AppStorage.print();

    _sessionId = sessionId;
    _user = user;

    if (shouldNotifyListeners) notifyListeners();
  }

  void logOut({
    bool shouldNotifyListeners = true,
  }) {
    AppStorage.sessionId.remove();
    AppStorage.userMap.remove();
    AppStorage.print();

    _sessionId = null;
    _user = null;

    if (shouldNotifyListeners) notifyListeners();
  }

  void navigateToLandingPage(BuildContext context) {
    if (_user == null) {
      context.pushAndRemoveUntil(const AuthOverviewPage());
      return;
    }

    context.pushAndRemoveUntil(const ProfilePage());
  }

  Future<User?> refresh() async {
    if (!hasSession) {
      return null;
    }

    try {
      // TODO: Implement refresh
      await Future.delayed(const Duration(seconds: 1));

      return _user;
    } catch (e) {
      log(e.toString(), error: e);
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<User?> selfUpdate({
    String? locale,
    bool optimisticUpdate = false,
  }) async {
    if (!hasSession || _user == null) {
      return null;
    }

    final User oldUser = _user!;

    if (optimisticUpdate) {
      _user = oldUser.copyWith(
        locale: locale,
      );
      notifyListeners();
    }

    try {
      // TODO: Implement self update
      await Future.delayed(const Duration(seconds: 1));

      return _user;
    } catch (e) {
      log(e.toString(), error: e);

      if (optimisticUpdate) {
        _user = oldUser;
      }

      return null;
    } finally {
      notifyListeners();
    }
  }

  void print() => log(toString());

  @override
  String toString() => 'UserProvider({ sessionId: $sessionId, user: $user })';
}
