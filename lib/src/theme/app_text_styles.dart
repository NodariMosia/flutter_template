part of 'app_theme.dart';

abstract final class AppTextStyles {
  /// Font used for page headlines.
  static const String juaFontFamily = 'Jua';

  /// Font used for English glyphs.
  static const String interFontFamily = 'Inter';

  /// Font used for Georgian glyphs.
  static const String notoSansGeorgianFontFamily = 'NotoSansGeorgian';

  static final TextStyle _displayLarge = _buildDefaultTextStyle(
    fontSize: 57,
    lineHeight: 64,
    letterSpacing: -0.25,
    fontWeight: FontWeight.w700,
    fontFamily: juaFontFamily,
  );
  static final TextStyle _displayMedium = _buildDefaultTextStyle(
    fontSize: 42,
    lineHeight: 48,
    fontWeight: FontWeight.w700,
    fontFamily: juaFontFamily,
  );
  static final TextStyle _displaySmall = _buildDefaultTextStyle(
    fontSize: 34,
    lineHeight: 38,
    fontWeight: FontWeight.w700,
    fontFamily: juaFontFamily,
  );
  static final TextStyle _headlineLarge = _buildDefaultTextStyle(
    fontSize: 32,
    lineHeight: 40,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle _headlineMedium = _buildDefaultTextStyle(
    fontSize: 28,
    lineHeight: 36,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle _headlineSmall = _buildDefaultTextStyle(
    fontSize: 24,
    lineHeight: 32,
    letterSpacing: 0.4,
    fontWeight: FontWeight.w700,
  );
  static final TextStyle _titleLarge = _buildDefaultTextStyle(
    fontSize: 20,
    lineHeight: 26,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle _titleMedium = _buildDefaultTextStyle(
    fontSize: 18,
    lineHeight: 24,
    letterSpacing: 0.15,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle _titleSmall = _buildDefaultTextStyle(
    fontSize: 14,
    lineHeight: 19,
    letterSpacing: -0.32,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle _labelLarge = _buildDefaultTextStyle(
    fontSize: 14,
    lineHeight: 19,
    letterSpacing: -0.28,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle _labelMedium = _buildDefaultTextStyle(
    fontSize: 12,
    lineHeight: 16,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle _labelSmall = _buildDefaultTextStyle(
    fontSize: 11,
    lineHeight: 14,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
  );
  static final TextStyle _bodyLarge = _buildDefaultTextStyle(
    fontSize: 16,
    lineHeight: 22,
    letterSpacing: -0.32,
  );
  static final TextStyle _bodyMedium = _buildDefaultTextStyle(
    fontSize: 14,
    lineHeight: 18,
    letterSpacing: -0.28,
  );
  static final TextStyle _bodySmall = _buildDefaultTextStyle(
    fontSize: 12,
    lineHeight: 16,
    letterSpacing: -0.24,
  );

  static TextStyle _buildDefaultTextStyle({
    required double fontSize,
    required double lineHeight,
    double letterSpacing = 0.0,
    FontWeight fontWeight = FontWeight.w400,
    String? fontFamily,
  }) {
    return TextStyle(
      fontFamily: fontFamily,
      height: lineHeight / fontSize,
      fontSize: fontSize,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
      fontStyle: FontStyle.normal,
      decoration: TextDecoration.none,
      textBaseline: TextBaseline.alphabetic,
      leadingDistribution: TextLeadingDistribution.even,
    );
  }

  static final TextTheme _colorlessTextTheme = TextTheme(
    displayLarge: _displayLarge,
    displayMedium: _displayMedium,
    displaySmall: _displaySmall,
    headlineLarge: _headlineLarge,
    headlineMedium: _headlineMedium,
    headlineSmall: _headlineSmall,
    titleLarge: _titleLarge,
    titleMedium: _titleMedium,
    titleSmall: _titleSmall,
    labelLarge: _labelLarge,
    labelMedium: _labelMedium,
    labelSmall: _labelSmall,
    bodyLarge: _bodyLarge,
    bodyMedium: _bodyMedium,
    bodySmall: _bodySmall,
  );

  static final TextTheme _darkTextTheme = _colorlessTextTheme.apply(
    bodyColor: AppColors.fromBrightness(Brightness.dark).colorScheme.onSurface,
    displayColor: AppColors.fromBrightness(Brightness.dark).colorScheme.onSurface,
  );
  static final TextTheme _lightTextTheme = _colorlessTextTheme.apply(
    bodyColor: AppColors.fromBrightness(Brightness.light).colorScheme.onSurface,
    displayColor: AppColors.fromBrightness(Brightness.light).colorScheme.onSurface,
  );

  static TextTheme textTheme(Brightness brightness) {
    return brightness == Brightness.dark ? _darkTextTheme : _lightTextTheme;
  }

  static TextTheme of(BuildContext context) {
    return textTheme(Theme.of(context).brightness);
  }
}
