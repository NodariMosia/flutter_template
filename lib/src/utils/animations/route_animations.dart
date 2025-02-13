import 'package:flutter/material.dart';

import 'package:animations/animations.dart';

export 'package:animations/animations.dart' show SharedAxisTransitionType;

class SharedAxisRouteAnimations extends PageRouteBuilder {
  final Widget page;

  SharedAxisRouteAnimations(this.page, SharedAxisTransitionType type)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return SharedAxisTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              transitionType: type,
              child: child,
            );
          },
        );
}

class FadeThroughRouteAnimations extends PageRouteBuilder {
  final Widget page;

  FadeThroughRouteAnimations(this.page)
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) {
            return page;
          },
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) {
            return FadeThroughTransition(
              animation: animation,
              secondaryAnimation: secondaryAnimation,
              child: child,
            );
          },
        );
}

class CupertinoPageRouteBuilder extends PageRoute {
  final PageTransitionsBuilder matchingBuilder = const CupertinoPageTransitionsBuilder();
  final Widget page;

  CupertinoPageRouteBuilder(this.page);

  @override
  bool get maintainState => true;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => const Duration(milliseconds: 500);

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return page;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return matchingBuilder.buildTransitions(
      this,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
