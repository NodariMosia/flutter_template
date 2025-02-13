import 'dart:developer';

abstract final class AppGenericCache {
  static Map<String, dynamic>? _maybeCache;

  static void init([Map<String, dynamic> initialCache = const {}]) {
    if (_maybeCache != null) {
      log('AppGenericCache is already initialized.');
      return;
    }

    _maybeCache = {...initialCache};
  }

  static Map<String, dynamic> get _cache {
    if (_maybeCache == null) {
      throw StateError('AppGenericCache not initialized, call #init first.');
    }

    return _maybeCache!;
  }

  /// Returns true if the cache contains the [key].
  static bool has(String key) => _cache.containsKey(key);

  /// Associates the [key] with the given [value].
  static T set<T>(String key, T value) => _cache[key] = value;

  /// Returns the value associated with [key] or `null` if [key] is not in the cache.
  /// If [defaultValue] is specified, it is returned in case the key does not exist.
  static T? get<T>(String key, {T? defaultValue}) => _cache[key] ?? defaultValue;

  /// Removes the entry associated with [key] and returns its value
  /// or `null` if [key] is not in the cache.
  static T? remove<T>(String key) => _cache.remove(key);

  /// Removes all entries from the cache.
  static void clear() => _cache.clear();

  /// Returns shallow copy of the underlying cache map. Use only for debugging.
  /// Do not modify this map directly, use the class methods instead.
  static Map<String, dynamic> toMap() => {..._cache};

  static void print() => log('AppGenericCache({ cache: $_cache })');
}
