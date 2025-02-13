part of '../app_storage.dart';

final class ThemeModeStore extends _AppHiveObjectStore<ThemeMode> {
  const ThemeModeStore._() : super._();

  @override
  String get cacheKey => 'themeMode';

  /// Sets the [themeMode] in cache. If [themeMode] is `null`, entry is removed from cache.
  @override
  Future<void> set(ThemeMode? themeMode) {
    return themeMode == null
        ? _AppHiveBox.remove(cacheKey)
        : _AppHiveBox.set<int>(cacheKey, themeMode.index);
  }

  /// Returns the themeMode from cache. If it is not in the cache, returns [defaultValue].
  @override
  ThemeMode? get({ThemeMode? defaultValue}) {
    final int? themeModeIndex = _AppHiveBox.get<int>(cacheKey);

    return themeModeIndex == null || themeModeIndex < 0
        ? null
        : ThemeMode.values.elementAtOrNull(themeModeIndex);
  }
}
