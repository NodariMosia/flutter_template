part of 'app_theme.dart';

abstract final class AppThemeData {
  static const BorderRadius _commonBorderRadius = BorderRadius.all(Radius.circular(6));

  static ThemeData _themeData(Brightness brightness) {
    final TextTheme textTheme = AppTextStyles.textTheme(brightness);

    final AppColors appColors = AppColors.fromBrightness(brightness);
    final ColorScheme colorScheme = appColors.colorScheme;

    final IconThemeData iconThemeData = IconThemeData(
      size: 24,
      color: colorScheme.onSurface,
    );

    OutlineInputBorder inputBorder(Color color) {
      return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1),
        borderRadius: _commonBorderRadius,
      );
    }

    return ThemeData(
      // TYPOGRAPHY & ICONOGRAPHY

      fontFamily: AppTextStyles.interFontFamily,
      fontFamilyFallback: const [AppTextStyles.notoSansGeorgianFontFamily],
      textTheme: textTheme,
      iconTheme: iconThemeData,

      // COLORS

      brightness: brightness,
      colorScheme: colorScheme,
      canvasColor: colorScheme.surface,
      scaffoldBackgroundColor: colorScheme.surface,
      disabledColor: appColors.disabled,
      dividerColor: appColors.divider,
      focusColor: colorScheme.primary,
      highlightColor: appColors.highlight,
      hintColor: appColors.hint,
      splashColor: appColors.splash,

      // GENERAL CONFIGURATION

      useMaterial3: true,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colorScheme.surface,
        contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 14),
        outlineBorder: BorderSide(color: colorScheme.outline),
        activeIndicatorBorder: BorderSide(color: colorScheme.outline),
        border: inputBorder(colorScheme.outline),
        enabledBorder: inputBorder(colorScheme.outline),
        disabledBorder: inputBorder(appColors.disabled),
        errorBorder: inputBorder(colorScheme.error),
        focusedBorder: inputBorder(colorScheme.primary),
        focusedErrorBorder: inputBorder(colorScheme.error),
        errorStyle: AppTextStyles._labelMedium.copyWith(
          color: colorScheme.error,
        ),
        helperStyle: AppTextStyles._labelMedium.copyWith(
          color: appColors.hint,
        ),
        hintStyle: AppTextStyles._bodyMedium.copyWith(
          color: appColors.hint,
        ),
        labelStyle: AppTextStyles._bodyLarge.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w500,
        ),
        floatingLabelStyle: AppTextStyles._labelLarge.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      scrollbarTheme: ScrollbarThemeData(
        thumbColor: appColors.hint.toWSP,
      ),

      // COMPONENT THEMES

      actionIconTheme: ActionIconThemeData(
        backButtonIconBuilder: (_) => const Icon(
          Icons.arrow_back_ios_new_rounded,
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 4,
        backgroundColor: colorScheme.surface,
        foregroundColor: colorScheme.onSurface,
        surfaceTintColor: appColors.appBarSurfaceTint,
        shadowColor: colorScheme.shadow,
        iconTheme: iconThemeData,
        actionsIconTheme: iconThemeData,
        centerTitle: true,
        titleSpacing: 16,
        titleTextStyle: AppTextStyles._titleLarge.copyWith(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        elevation: 1,
        backgroundColor: colorScheme.surface,
        selectedItemColor: colorScheme.onSurface,
        unselectedItemColor: appColors.disabled,
        selectedIconTheme: iconThemeData,
        unselectedIconTheme: iconThemeData,
        selectedLabelStyle: AppTextStyles._labelSmall.copyWith(
          color: colorScheme.onSurface,
        ),
        unselectedLabelStyle: AppTextStyles._labelSmall.copyWith(
          color: appColors.disabled,
        ),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: colorScheme.surface,
        modalBarrierColor: colorScheme.shadow,
        modalBackgroundColor: colorScheme.surface,
        dragHandleColor: appColors.hint,
        dragHandleSize: const Size(40, 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
      buttonTheme: ButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      cardTheme: const CardTheme(
        elevation: 1,
        margin: EdgeInsets.zero,
      ),
      checkboxTheme: CheckboxThemeData(
        checkColor: colorScheme.surface.toWSP,
        fillColor: colorScheme.onSurface.toWSP,
        side: BorderSide(width: 2, color: colorScheme.onSurface),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      chipTheme: ChipThemeData(
        padding: const EdgeInsets.all(8),
        selectedColor: colorScheme.secondary,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      dialogTheme: DialogTheme(
        backgroundColor: colorScheme.surfaceContainer,
        actionsPadding: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
      ),
      dividerTheme: DividerThemeData(
        space: 16,
        thickness: 1,
        color: appColors.divider,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: colorScheme.surface,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(16)),
        ),
        endShape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(left: Radius.circular(16)),
        ),
      ),
      dropdownMenuTheme: DropdownMenuThemeData(
        menuStyle: MenuStyle(
          backgroundColor: colorScheme.surface.toWSP,
          elevation: const WidgetStatePropertyAll(4),
          padding: const WidgetStatePropertyAll(EdgeInsets.zero),
          shape: const WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: _commonBorderRadius),
          shadowColor: colorScheme.shadow,
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          // backgroundColor: colorScheme.onBackground,
          // foregroundColor: colorScheme.background,
          disabledBackgroundColor: appColors.disabled,
          disabledForegroundColor: colorScheme.onSurface,
          textStyle: textTheme.titleMedium,
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: _commonBorderRadius),
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          shape: const RoundedRectangleBorder(borderRadius: _commonBorderRadius),
          side: BorderSide(color: colorScheme.outline, width: 1),
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          textStyle: textTheme.bodyMedium!.copyWith(height: 17 / 14),
        ),
      ),
      popupMenuTheme: PopupMenuThemeData(
        elevation: 8,
        color: colorScheme.surface,
        position: PopupMenuPosition.under,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: colorScheme.onSurface,
      ),
      segmentedButtonTheme: const SegmentedButtonThemeData(
        selectedIcon: Icon(Icons.check_rounded),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          side: BorderSide(color: colorScheme.outline, width: 1),
          shape: const RoundedRectangleBorder(borderRadius: _commonBorderRadius),
          backgroundColor: colorScheme.surface,
          foregroundColor: colorScheme.onSurface,
          textStyle: textTheme.bodyMedium!.copyWith(height: 17 / 14),
        ),
      ),
      textSelectionTheme: TextSelectionThemeData(
        selectionColor: colorScheme.secondary,
      ),
    );
  }

  static final ThemeData _darkThemeData = _themeData(Brightness.dark);
  static final ThemeData _lightThemeData = _themeData(Brightness.light);

  static ThemeData themeData(Brightness brightness) {
    return brightness == Brightness.dark ? _darkThemeData : _lightThemeData;
  }

  static ThemeData of(BuildContext context) {
    return themeData(Theme.of(context).brightness);
  }
}
