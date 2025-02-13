import 'package:flutter/material.dart';

class AppCircularProgressIndicator extends StatelessWidget {
  static const double _defaultStrokeWidth = 4.0;

  final EdgeInsets margin;
  final Alignment alignment;
  final double strokeWidth;
  final double? size;

  const AppCircularProgressIndicator({
    required this.margin,
    required this.alignment,
    this.strokeWidth = _defaultStrokeWidth,
    this.size,
    super.key,
  });

  const AppCircularProgressIndicator.topCenter({
    this.margin = const EdgeInsets.only(top: 24),
    this.alignment = Alignment.topCenter,
    this.strokeWidth = _defaultStrokeWidth,
    this.size,
    super.key,
  });

  const AppCircularProgressIndicator.center({
    this.margin = EdgeInsets.zero,
    this.alignment = Alignment.center,
    this.strokeWidth = _defaultStrokeWidth,
    this.size,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Widget innerWidget = Container(
      margin: margin,
      alignment: alignment,
      child: SizedBox(
        width: size,
        height: size,
        child: const CircularProgressIndicator(
          strokeCap: StrokeCap.round,
          semanticsLabel: 'Loading',
        ),
      ),
    );

    return innerWidget;
  }
}
