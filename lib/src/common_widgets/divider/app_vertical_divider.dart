import 'package:flutter/material.dart';

class AppVerticalDivider extends StatelessWidget {
  final double hpadding;
  final double height;
  final Color? color;

  const AppVerticalDivider({
    this.hpadding = 0,
    this.height = 1,
    this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: EdgeInsets.symmetric(horizontal: hpadding),
      decoration: BoxDecoration(
        color: color ?? Theme.of(context).dividerColor,
        borderRadius: BorderRadius.circular(height),
      ),
    );
  }
}
