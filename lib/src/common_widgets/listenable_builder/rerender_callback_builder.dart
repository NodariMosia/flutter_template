import 'package:flutter/material.dart';

class RerenderCallbackBuilder extends StatefulWidget {
  final Widget? child;
  final Widget Function(
    BuildContext context,
    VoidCallback rerender,
    Widget? child,
  ) builder;

  const RerenderCallbackBuilder({
    required this.builder,
    this.child,
    super.key,
  });

  @override
  State<RerenderCallbackBuilder> createState() => _RerenderCallbackBuilderState();
}

class _RerenderCallbackBuilderState extends State<RerenderCallbackBuilder> {
  final ValueNotifier<bool> _rerenderFlag = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _rerenderFlag,
      builder: (BuildContext ctx, _, Widget? child) {
        return widget.builder(ctx, _rerender, child);
      },
      child: widget.child,
    );
  }

  void _rerender() {
    _rerenderFlag.value = !_rerenderFlag.value;
  }
}
