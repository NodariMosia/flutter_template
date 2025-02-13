import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ValueListenableBuilder2<A, B> extends StatelessWidget {
  final ValueListenable<A> valueListenable1;
  final ValueListenable<B> valueListenable2;
  final Widget Function(BuildContext context, A value1, B value2, Widget? child) builder;
  final Widget? child;

  const ValueListenableBuilder2({
    required this.valueListenable1,
    required this.valueListenable2,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: valueListenable1,
      builder: (_, value1, __) {
        return ValueListenableBuilder<B>(
          valueListenable: valueListenable2,
          builder: (_, value2, __) {
            return builder(context, value1, value2, child);
          },
        );
      },
    );
  }
}
