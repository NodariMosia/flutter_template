import 'dart:async';

import 'package:flutter/material.dart';

import 'package:another_flushbar/flushbar.dart';

import 'package:flutter_template/src/config/global_config.dart';
import 'package:flutter_template/src/providers/app_theme_provider.dart';
import 'package:flutter_template/src/theme/app_theme.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

abstract final class AppFlushbarIcons {
  static AppColors get _appColors => AppColors.fromBrightness(AppThemeProvider.instance.brightness);

  static Widget get copied => const Icon(
        Icons.copy_rounded,
        color: AppColors.green,
        size: 20,
      );

  static Widget get info => Icon(
        Icons.info_outline_rounded,
        color: _appColors.colorScheme.primary,
        size: 20,
      );

  static Widget get error => Icon(
        Icons.error_outline_rounded,
        color: _appColors.colorScheme.error,
        size: 20,
      );
}

class AppFlushbar {
  static const Duration _defaultStayDuration = Duration(milliseconds: 2300);
  static const Duration _defaultAnimationDuration = Duration(milliseconds: 750);

  static Timer? _appSnackbarTimer;

  static bool canShowSnackbar() {
    final bool isTimerActive = _appSnackbarTimer?.isActive ?? false;

    return GlobalConfig.appScaffoldMessengerKey.currentState != null && !isTimerActive;
  }

  final String text;
  final Widget? icon;
  final double iconTextGap;
  final EdgeInsets margin;
  final FlushbarPosition flushbarPosition;
  final Curve curve;
  final Duration stayDuration;
  final Duration animationDuration;

  const AppFlushbar({
    required this.text,
    this.icon,
    this.iconTextGap = 4,
    this.margin = const EdgeInsets.symmetric(horizontal: 16, vertical: 28),
    this.flushbarPosition = FlushbarPosition.TOP,
    this.curve = Curves.easeInOut,
    this.stayDuration = _defaultStayDuration,
    this.animationDuration = _defaultAnimationDuration,
  });

  AppFlushbar.bottomInfo(String text)
      : this(
          text: text,
          icon: AppFlushbarIcons.info,
          flushbarPosition: FlushbarPosition.BOTTOM,
        );

  AppFlushbar.bottomError(String text)
      : this(
          text: text,
          icon: AppFlushbarIcons.error,
          flushbarPosition: FlushbarPosition.BOTTOM,
        );

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason>? showSnackbar() {
    if (!canShowSnackbar()) {
      return null;
    }

    _appSnackbarTimer = Timer(stayDuration * 1.2, () {});

    return GlobalConfig.appScaffoldMessengerKey.currentState?.showSnackBar(buildSnackbar());
  }

  Future<dynamic> showFlushbar(BuildContext context) {
    return buildFlushbar().show(context);
  }

  SnackBar buildSnackbar() {
    return SnackBar(
      margin: margin,
      padding: EdgeInsets.zero,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
      duration: stayDuration,
      content: _contentBuilder(),
    );
  }

  Flushbar buildFlushbar() {
    return Flushbar(
      margin: margin,
      padding: EdgeInsets.zero,
      flushbarPosition: flushbarPosition,
      backgroundColor: Colors.transparent,
      forwardAnimationCurve: curve,
      reverseAnimationCurve: curve,
      duration: stayDuration,
      animationDuration: animationDuration,
      messageText: _contentBuilder(),
    );
  }

  Widget _contentBuilder() {
    return Builder(
      builder: (BuildContext ctx) => Align(
        alignment: Alignment.bottomCenter,
        heightFactor: 1,
        child: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 4),
          constraints: BoxConstraints(maxWidth: ctx.screenWidth - 36),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: ctx.colorScheme.surface,
            boxShadow: [
              BoxShadow(
                blurRadius: 2.5,
                offset: const Offset(0, 2.5),
                color: ctx.appColors.shadow,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null)
                Padding(
                  padding: EdgeInsets.only(right: iconTextGap),
                  child: icon!,
                ),
              Flexible(
                child: Text(
                  text,
                  maxLines: 3,
                  style: ctx.textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
