part of 'app_storage.dart';

abstract final class _AppHiveBox {
  static Box? _maybeBox;

  static Future<void> init(String boxName) async {
    if (_maybeBox != null) {
      log('AppStorage is already initialized.');
      return;
    }

    await Hive.initFlutter();
    _maybeBox = await Hive.openBox(boxName);
  }

  static Box get _box {
    if (_maybeBox == null) {
      throw StateError('AppStorage not initialized, call #init first.');
    }

    return _maybeBox!;
  }

  /// See [Box.containsKey]
  static bool has(String key) => _box.containsKey(key);

  /// See [Box.put]
  static Future<void> set<T>(String key, T value) => _box.put(key, value);

  /// See [Box.get]
  static T? get<T>(String key, {T? defaultValue}) => _box.get(key, defaultValue: defaultValue);

  /// See [Box.delete]
  static Future<void> remove(String key) => _box.delete(key);

  /// See [Box.clear]
  static Future<void> clear() => _box.clear();

  /// See [Box.toMap]
  static Map<dynamic, dynamic> toMap() => _box.toMap();

  static void print() => log('AppStorage({ cache: ${toMap()} })');
}
