import 'package:flutter/material.dart';

class MultiListenableBuilder extends StatelessWidget {
  final List<Listenable> listenables;
  final Widget? child;
  final Widget Function(BuildContext context, Widget? child) builder;

  const MultiListenableBuilder({
    required this.listenables,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge(listenables),
      builder: builder,
      child: child,
    );
  }
}
