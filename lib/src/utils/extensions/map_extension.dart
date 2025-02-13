part of 'extensions.dart';

extension MapExtension<K, P> on Map<K, P> {
  /// Removes all entries with value `null`.
  Map<K, P> removeNulls() {
    removeWhere((key, value) => value == null);
    return this;
  }
}

extension MaybeMapExtension<K, P> on Map<K, P>? {
  /// Returns `null` if it is `null` or an empty [Map]. Otherwise returns self.
  Map<K, P>? get nullIfEmpty => isFalsy ? null : this;

  /// Returns `true` if it is `null` or an empty [Map], `false` otherwise.
  bool get isFalsy => this == null || this!.isEmpty;

  /// Returns `false` if it is `null` or an  empty [Map], `true` otherwise.
  bool get isTruthy => this != null && this!.isNotEmpty;
}
