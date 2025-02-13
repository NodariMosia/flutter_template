part of '../app_storage.dart';

final class SessionIdStore extends _AppHiveObjectStore<String> {
  const SessionIdStore._() : super._();

  @override
  String get cacheKey => 'sessionId';
}
