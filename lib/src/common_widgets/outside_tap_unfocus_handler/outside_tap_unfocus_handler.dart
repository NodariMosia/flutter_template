import 'package:flutter/material.dart';

class OutsideTapUnfocusHandler extends StatelessWidget {
  final Widget? child;

  const OutsideTapUnfocusHandler({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: _unfocus,
      child: child,
    );
  }

  void _unfocus(PointerDownEvent _) {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
