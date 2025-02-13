part of '../app_storage.dart';

final class LangCodeStore extends _AppHiveObjectStore<String> {
  const LangCodeStore._() : super._();

  @override
  String get cacheKey => 'langCode';
}
