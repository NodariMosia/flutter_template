import 'package:flutter/material.dart';

import 'package:flutter_template/src/utils/extensions/extensions.dart';

class MainTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final double iconGap;
  final bool enabled;
  final double? width;
  final double height;
  final EdgeInsets padding;
  final bool expanded;

  const MainTextButton({
    required this.text,
    required this.onPressed,
    this.prefixIcon,
    this.suffixIcon,
    this.iconGap = 6,
    this.enabled = true,
    this.width,
    this.height = 25,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    this.expanded = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? (expanded ? double.infinity : null),
      height: height,
      child: TextButton(
        onPressed: enabled ? onPressed : null,
        style: TextButton.styleFrom(
          padding: padding,
          minimumSize: Size.zero,
        ),
        child: Row(
          children: [
            if (prefixIcon != null) ...[
              prefixIcon!,
              SizedBox(width: iconGap),
            ],
            Text(
              text,
              style: context.textTheme.bodyMedium!.copyWith(height: 17 / 14),
            ),
            if (suffixIcon != null) ...[
              SizedBox(width: iconGap),
              suffixIcon!,
            ],
          ],
        ),
      ),
    );
  }
}
