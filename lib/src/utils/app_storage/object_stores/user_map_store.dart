part of '../app_storage.dart';

final class UserMapStore extends _AppHiveObjectStore<Map<String, dynamic>> {
  const UserMapStore._() : super._();

  @override
  String get cacheKey => 'userMap';

  /// Returns the userMap from cache. If it is not in the cache, returns [defaultValue].
  @override
  Map<String, dynamic>? get({Map<String, dynamic>? defaultValue}) {
    Map<dynamic, dynamic>? userMap = _AppHiveBox.get<Map<dynamic, dynamic>>(cacheKey);

    if (userMap == null) {
      return null;
    }

    // Cast userMap from Map<dynamic, dynamic> to Map<String, dynamic>.
    userMap = Map<String, dynamic>.from(userMap);

    return userMap as Map<String, dynamic>;
  }
}
