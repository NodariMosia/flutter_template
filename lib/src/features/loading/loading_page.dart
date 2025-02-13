import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/progress_indicator/app_circular_progress_indicator.dart';
import 'package:flutter_template/src/constants/widget_sizings.dart';
import 'package:flutter_template/src/features/auth/auth_overview_page.dart';
import 'package:flutter_template/src/models/user/user.dart';
import 'package:flutter_template/src/providers/user_provider.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => LoadingPageState();
}

class LoadingPageState extends State<LoadingPage> {
  final ValueNotifier<bool> loading = ValueNotifier<bool>(true);

  static const Duration _delayedNetworkDuration = Duration(seconds: 3);
  static const Duration _minimumDelayDuration = Duration(milliseconds: 600);

  late final Timer _delayedNetworkTimer;
  late final Timer _minimumDelayTimer;
  bool _loadingSequenceCompleted = false;
  bool _minimumTimerExpired = false;
  bool _sessionIsValid = false;
  double _opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    _loadSequence();
  }

  @override
  void dispose() {
    _delayedNetworkTimer.cancel();
    _minimumDelayTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: context.colorScheme.surface,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/icon-transparent.png',
                width: 150,
                height: 150,
              ),
              Gaps.h16,
              AnimatedOpacity(
                opacity: _opacityLevel,
                duration: const Duration(milliseconds: 200),
                child: const AppCircularProgressIndicator.topCenter(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _loadSequence() async {
    try {
      _delayedNetworkTimer = Timer(_delayedNetworkDuration, _onDelayedLoading);
      _minimumDelayTimer = Timer(_minimumDelayDuration, _onMinimumTimerExpired);

      await _initProviders();

      _onLoadingSequenceCompleted();
    } catch (e) {
      log(e.toString());
    }
  }

  void _onDelayedLoading() {
    setState(() => _opacityLevel = 1.0);
  }

  void _onMinimumTimerExpired() {
    _minimumTimerExpired = true;
    _checkDoneLoading();
  }

  void _onLoadingSequenceCompleted() {
    _loadingSequenceCompleted = true;
    _checkDoneLoading();
  }

  void _checkDoneLoading() async {
    if (_loadingSequenceCompleted && _minimumTimerExpired) {
      loading.value = false;

      if (!_sessionIsValid) {
        context.pushReplacement(const AuthOverviewPage());
        return;
      }

      UserProvider.instance.navigateToLandingPage(context);
    }
  }

  Future<void> _initProviders() async {
    if (!UserProvider.instance.hasSession) {
      log('No session id present.');
      return;
    }

    try {
      final User? user = await UserProvider.instance.refresh();

      if (user == null) {
        log('Fetching user failed.');
        return;
      }

      if (!mounted) return;

      _sessionIsValid = true;
    } catch (e) {
      log(e.toString(), error: e);
    }
  }
}
