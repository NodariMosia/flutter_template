part of 'extensions.dart';

extension StringExtension on String {
  /// Returns self if [length] is less than or equal to [maxLength].
  /// Otherwise returns a substring of [maxLength] - 3 length with `...` at the end.
  String wrapWithDots(int maxLength) {
    if (length <= maxLength) {
      return this;
    }

    return '${substring(0, maxLength - 3)}...';
  }

  /// Returns capitalized string. If [everyWord] is true, then every word
  /// is capitalized. Otherwise only the first word is capitalized.
  String capitalize({bool everyWord = false}) {
    if (isEmpty) {
      return this;
    }

    if (length == 1) {
      return this[0].toUpperCase();
    }

    if (!everyWord) {
      return '${this[0].toUpperCase()}${substring(1)}';
    }

    return split(' ').map((str) => str.capitalize()).join(' ');
  }
}

extension MaybeStringExtension on String? {
  /// Returns `null` if it is `null` or an empty [String]. Otherwise returns self.
  String? get nullIfEmpty => isFalsy ? null : this;

  /// Returns `true` if it is `null` or an empty [String], `false` otherwise.
  bool get isFalsy => this == null || this!.isEmpty;

  /// Returns `false` if it is `null` or an empty [String], `true` otherwise.
  bool get isTruthy => this != null && this!.isNotEmpty;
}
