import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/progress_indicator/app_circular_progress_indicator.dart';

class MainActionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final bool shouldShowSpinner;
  final double? width;
  final double height;
  final bool expanded;

  const MainActionButton({
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.shouldShowSpinner = false,
    this.width,
    this.height = 52,
    this.expanded = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? width ?? double.infinity : width,
      height: height,
      child: ElevatedButton(
        onPressed: (enabled && !shouldShowSpinner) ? onPressed : null,
        child: shouldShowSpinner ? const AppCircularProgressIndicator.center(size: 30) : Text(text),
      ),
    );
  }
}
