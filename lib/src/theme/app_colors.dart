part of 'app_theme.dart';

class AppColors {
  // STATIC COLOR DECLARATIONS

  static const Color themeColor = Color.fromRGBO(253, 180, 88, 1); // old: (236, 137, 81, 1)

  static const Color orange = Color.fromRGBO(255, 153, 0, 1);
  static const Color green = Color.fromRGBO(0, 204, 102, 1);
  static const Color lightGreen = Color.fromRGBO(163, 236, 207, 1);
  static const Color lightRed = Color.fromRGBO(232, 142, 151, 1);
  static const Color red = Color.fromRGBO(240, 60, 79, 1);
  static const Color darkBlue = Color.fromRGBO(101, 131, 177, 1);
  static const Color lightBlue = Color.fromRGBO(163, 192, 236, 1);

  static const Color black = Color.fromRGBO(0, 0, 0, 1);
  static const Color darkGray = Color.fromRGBO(115, 127, 146, 1);
  static const Color silver = Color.fromRGBO(127, 131, 138, 1);
  static const Color midGray = Color.fromRGBO(155, 163, 177, 1);
  static const Color lightGray = Color.fromRGBO(216, 216, 216, 1);
  static const Color white = Color.fromRGBO(255, 255, 255, 1);

  static const MaterialColor greyBlue = MaterialColor(
    _greyBluePrimaryValue,
    <int, Color>{
      50: Color.fromRGBO(236, 239, 241, 1),
      100: Color.fromRGBO(207, 216, 220, 1),
      200: Color.fromRGBO(176, 190, 197, 1),
      300: Color.fromRGBO(148, 160, 170, 1),
      400: Color.fromRGBO(124, 140, 150, 1),
      500: Color(_greyBluePrimaryValue),
      600: Color.fromRGBO(101, 112, 129, 1),
      700: Color.fromRGBO(55, 61, 66, 1),
      800: Color.fromRGBO(30, 34, 37, 1),
      850: Color.fromRGBO(24, 27, 31, 1),
      900: Color.fromRGBO(16, 18, 20, 1),
    },
  );
  static const int _greyBluePrimaryValue = 0xFF737F92;

  static const Color _shadowDark = Color.fromRGBO(200, 200, 200, 0.2);
  static const Color _shadowLight = Color.fromRGBO(0, 0, 0, 0.2);
  // static const Color _splashDark = Color.fromRGBO(199, 255, 248, 0.2);
  // static const Color _splashLight = Color.fromRGBO(199, 255, 248, 0.2);
  static const Color _splashDark = Color.fromRGBO(101, 131, 177, 0.2);
  static const Color _splashLight = Color.fromRGBO(163, 192, 236, 0.2);
  // static const Color _highlightDark = Color.fromRGBO(199, 255, 248, 0.15);
  // static const Color _highlightLight = Color.fromRGBO(199, 255, 248, 0.15);
  static const Color _highlightDark = Color.fromRGBO(101, 131, 177, 0.15);
  static const Color _highlightLight = Color.fromRGBO(163, 192, 236, 0.15);
  static const Color _shimmerBaseDark = Color.fromRGBO(34, 34, 39, 1);
  static const Color _shimmerBaseLight = Color.fromRGBO(238, 238, 238, 1);
  static const Color _shimmerHighlightDark = Color.fromRGBO(65, 65, 65, 1);
  static const Color _shimmerHighlightLight = Color.fromRGBO(250, 250, 250, 1);

  // LIGHT AND DARK `ColorScheme`s

  static final ColorScheme _colorSchemeLight = ColorScheme(
    brightness: Brightness.light,
    primary: darkBlue,
    onPrimary: white,
    secondary: lightBlue,
    onSecondary: black,
    tertiary: themeColor,
    onTertiary: black,
    error: red,
    onError: white,
    surface: white,
    onSurface: greyBlue[900]!,
    surfaceContainerLowest: Colors.grey[50],
    surfaceContainerLow: Colors.grey[100],
    surfaceContainer: Colors.grey[200],
    surfaceContainerHigh: Colors.grey[300],
    surfaceContainerHighest: Colors.grey[400],
    outline: darkGray,
    outlineVariant: greyBlue[400],
    scrim: _shadowLight,
    shadow: _shadowLight,
    surfaceTint: Colors.transparent,
  );

  static final ColorScheme _colorSchemeDark = ColorScheme(
    brightness: Brightness.dark,
    primary: lightBlue,
    onPrimary: black,
    secondary: darkBlue,
    onSecondary: white,
    tertiary: themeColor,
    onTertiary: black,
    error: red,
    onError: white,
    surface: greyBlue[900]!,
    onSurface: white,
    surfaceContainerLowest: greyBlue[850]!,
    surfaceContainerLow: greyBlue[800]!,
    surfaceContainer: greyBlue[700],
    surfaceContainerHigh: greyBlue[600],
    surfaceContainerHighest: greyBlue[500],
    outline: lightGray,
    outlineVariant: greyBlue[500],
    scrim: _shadowDark,
    shadow: _shadowDark,
    surfaceTint: Colors.transparent,
  );

  // CUSTOM THEMED COLORS OUTSIDE FLUTTER'S `ColorScheme`

  final Brightness brightness;
  late final ColorScheme colorScheme;
  late final Color disabled;
  late final Color divider;
  late final Color hint;
  late final Color shadow;
  late final Color splash;
  late final Color highlight;
  late final Color shimmerBase;
  late final Color shimmerHighlight;
  late final Color appBarSurfaceTint;
  late final Color success;

  AppColors._(this.brightness) {
    final bool isDark = brightness == Brightness.dark;

    colorScheme = isDark ? _colorSchemeDark : _colorSchemeLight;

    disabled = isDark ? silver : midGray;
    divider = isDark ? greyBlue[700]! : lightGray;
    hint = midGray;

    shadow = isDark ? _shadowDark : _shadowLight;
    splash = isDark ? _splashDark : _splashLight;
    highlight = isDark ? _highlightDark : _highlightLight;
    shimmerBase = isDark ? _shimmerBaseDark : _shimmerBaseLight;
    shimmerHighlight = isDark ? _shimmerHighlightDark : _shimmerHighlightLight;
    appBarSurfaceTint = isDark ? greyBlue[100]! : greyBlue[600]!;

    success = isDark ? green : green;
  }

  static final AppColors _instanceDark = AppColors._(Brightness.dark);
  static final AppColors _instanceLight = AppColors._(Brightness.light);

  factory AppColors.fromBrightness(Brightness brightness) {
    return brightness == Brightness.dark ? _instanceDark : _instanceLight;
  }

  factory AppColors.of(BuildContext context) {
    return AppColors.fromBrightness(Theme.of(context).brightness);
  }
}
