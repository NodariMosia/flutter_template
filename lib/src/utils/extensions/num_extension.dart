part of 'extensions.dart';

extension NumExtension on num {
  /// Rounds [this] to [fractionDigits] significant digits and returns it as double
  double toDoubleAsFixed(int fractionDigits) {
    final num mod = pow(10.0, fractionDigits);
    return (this * mod).round().toDouble() / mod;
  }
}
