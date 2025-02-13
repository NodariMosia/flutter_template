part of 'extensions.dart';

extension ColorExtension on Color {
  /// Turns `Color` into `WidgetStatePropertyAll<Color>`.
  WidgetStatePropertyAll<Color> get toWSP => WidgetStatePropertyAll(this);
}
