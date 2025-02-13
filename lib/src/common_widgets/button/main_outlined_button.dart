import 'package:flutter/material.dart';

class MainOutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool enabled;
  final double? width;
  final double height;
  final bool expanded;

  const MainOutlinedButton({
    required this.text,
    required this.onPressed,
    this.enabled = true,
    this.width,
    this.height = 38,
    this.expanded = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: expanded ? width ?? double.infinity : width,
      height: height,
      child: OutlinedButton(
        onPressed: enabled ? onPressed : null,
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(4),
        ),
        child: Text(text),
      ),
    );
  }
}
