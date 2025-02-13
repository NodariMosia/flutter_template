part of 'extensions.dart';

extension BuildContextExtension on BuildContext {
  // LOCALE METHODS

  Locale get locale => Localizations.maybeLocaleOf(this) ?? const Locale('en');
  AppL10n get l10n => AppL10n.of(this) ?? AppL10nEn();

  // MEDIA QUERY METHODS

  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get screenWidth => mediaQuery.size.width;
  double get screenHeight => mediaQuery.size.height;
  double get appBarHeightWithPadding => mediaQuery.padding.top + kAppToolbarHeight;
  double get screenHeightWithoutAppBar => screenHeight - appBarHeightWithPadding;

  // THEME METHODS

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  Brightness get brightness => theme.brightness;

  AppColors get appColors => AppColors.of(this);
  ColorScheme get colorScheme => appColors.colorScheme;

  // NAVIGATOR METHODS

  Future<dynamic> push(
    Widget page, {
    bool isCupertino = true,
    bool rootNavigator = false,
    SharedAxisTransitionType transitionType = SharedAxisTransitionType.scaled,
    Function(dynamic value)? callback,
  }) {
    final Route newRoute = isCupertino
        ? CupertinoPageRouteBuilder(page)
        : SharedAxisRouteAnimations(page, transitionType);

    return Navigator.of(this, rootNavigator: rootNavigator)
        .push(newRoute)
        .then((value) => callback?.call(value));
  }

  Future<dynamic> pushReplacement(
    Widget page, {
    bool isCupertino = false,
    bool rootNavigator = false,
    SharedAxisTransitionType transitionType = SharedAxisTransitionType.scaled,
    Function(dynamic value)? callback,
  }) {
    final Route newRoute = isCupertino
        ? CupertinoPageRouteBuilder(page)
        : SharedAxisRouteAnimations(page, transitionType);

    return Navigator.of(this, rootNavigator: rootNavigator)
        .pushReplacement(newRoute)
        .then((value) => callback?.call(value));
  }

  Future<dynamic> pushAndRemoveUntil(
    Widget page, {
    bool isCupertino = false,
    bool rootNavigator = false,
    SharedAxisTransitionType transitionType = SharedAxisTransitionType.scaled,
    bool Function(Route<dynamic> route)? predicate,
  }) {
    final Route newRoute = isCupertino
        ? CupertinoPageRouteBuilder(page)
        : SharedAxisRouteAnimations(page, transitionType);

    return Navigator.of(this, rootNavigator: rootNavigator)
        .pushAndRemoveUntil(newRoute, predicate ?? (_) => false);
  }

  void pop<T>({
    int times = 1,
    T? result,
    bool rootNavigator = false,
  }) {
    for (int i = 0; i < times; i++) {
      Navigator.of(this, rootNavigator: rootNavigator).pop(result);
    }
  }

  void popUntil<T>(
    bool Function(Route<dynamic> route) predicate, {
    bool rootNavigator = false,
  }) {
    Navigator.of(this, rootNavigator: rootNavigator).popUntil(predicate);
  }
}
