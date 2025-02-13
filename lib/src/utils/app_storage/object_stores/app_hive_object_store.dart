part of '../app_storage.dart';

abstract interface class _AppHiveObjectStore<T> {
  const _AppHiveObjectStore._();

  String get cacheKey;

  bool has() => _AppHiveBox.has(cacheKey);

  /// Sets the [value] in cache. If [value] is `null`, entry is removed from cache.
  Future<void> set(T? value) =>
      value == null ? _AppHiveBox.remove(cacheKey) : _AppHiveBox.set<T>(cacheKey, value);

  /// Returns the value from cache. If it is not in the cache, returns [defaultValue].
  T? get({T? defaultValue}) => _AppHiveBox.get<T>(cacheKey, defaultValue: defaultValue);

  /// Removes the entry from cache.
  Future<void> remove() => _AppHiveBox.remove(cacheKey);
}
