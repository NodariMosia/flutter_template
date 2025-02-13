import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/button/main_action_button.dart';
import 'package:flutter_template/src/common_widgets/listenable_builder/multi_value_listenable_builder.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

class AppBottomSheet extends StatefulWidget {
  final double? height;
  final double? maxHeight;
  final VoidCallback? onBack;
  final Widget? child;
  final String? buttonLabel;
  final VoidCallback? onButtonPressed;
  final bool extendOnDraggingUp;
  final bool closeKeyboardOnBodyTap;

  const AppBottomSheet({
    this.height,
    this.maxHeight,
    this.onBack,
    this.child,
    this.buttonLabel,
    this.onButtonPressed,
    this.extendOnDraggingUp = false,
    this.closeKeyboardOnBodyTap = true,
    super.key,
  });

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet> with SingleTickerProviderStateMixin {
  late final ValueNotifier<double?> _heightNotifier = ValueNotifier<double?>(widget.height);
  final ValueNotifier<double> _yOffsetNotifier = ValueNotifier<double>(0.0);
  final ValueNotifier<bool> _isExpandedNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _isDraggingNotifier = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _heightNotifier.dispose();
    _yOffsetNotifier.dispose();
    _isExpandedNotifier.dispose();
    _isDraggingNotifier.dispose();
    super.dispose();
  }

  double get _maxHeight {
    if (widget.maxHeight != null && widget.maxHeight! >= 0) {
      return widget.maxHeight!;
    }

    return context.screenHeightWithoutAppBar;
  }

  @override
  Widget build(BuildContext context) {
    final double bottomInset = context.mediaQuery.viewInsets.bottom;
    const double bottomPadding = 32;
    final double safeAreaBottomPadding = bottomPadding + bottomInset;

    return GestureDetector(
      onTap: widget.closeKeyboardOnBodyTap
          ? () => FocusManager.instance.primaryFocus?.unfocus()
          : null,
      behavior: HitTestBehavior.opaque,
      child: ValueListenableBuilder2(
        valueListenable1: _heightNotifier,
        valueListenable2: _isDraggingNotifier,
        builder: (_, double? height, bool isDragging, Widget? child) => AnimatedContainer(
          duration: isDragging ? Duration.zero : const Duration(milliseconds: 100),
          constraints: BoxConstraints(maxHeight: _maxHeight),
          height: height,
          child: child,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onVerticalDragStart: widget.extendOnDraggingUp ? _onVerticalDragStart : null,
              onVerticalDragUpdate: widget.extendOnDraggingUp ? _onVerticalDragUpdate : null,
              onVerticalDragEnd: widget.extendOnDraggingUp ? _onVerticalDragEnd : null,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 21),
                child: FractionallySizedBox(
                  widthFactor: 0.2,
                  child: Container(
                    height: 4,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: context.appColors.divider,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
            ),
            if (widget.onBack != null)
              Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 2),
                child: IconButton(
                  onPressed: widget.onBack,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 26),
                ),
              ),
            if (widget.child != null) widget.child!,
            if (widget.onButtonPressed != null && widget.buttonLabel != null)
              Padding(
                padding: EdgeInsets.fromLTRB(16, 10, 16, safeAreaBottomPadding),
                child: MainActionButton(
                  onPressed: widget.onButtonPressed!,
                  text: widget.buttonLabel!,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _onVerticalDragStart(DragStartDetails details) {
    if (!widget.extendOnDraggingUp) {
      return;
    }

    _isDraggingNotifier.value = true;
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (!widget.extendOnDraggingUp) {
      return;
    }

    if (_heightNotifier.value == null) {
      return;
    }

    _yOffsetNotifier.value = details.localPosition.dy;
    _heightNotifier.value = _isExpandedNotifier.value
        ? (_maxHeight - _yOffsetNotifier.value)
        : (widget.height! - _yOffsetNotifier.value);
  }

  void _onVerticalDragEnd(DragEndDetails details) {
    if (!widget.extendOnDraggingUp) {
      return;
    }

    if (widget.height == null) {
      return;
    }

    if (!_isExpandedNotifier.value &&
        _yOffsetNotifier.value > 0 &&
        _yOffsetNotifier.value.abs() > widget.height! * 0.15) {
      context.pop();
      return;
    }

    if (_yOffsetNotifier.value.abs() > widget.height! * 0.15) {
      _isExpandedNotifier.value = _yOffsetNotifier.value < 0;
    }
    _heightNotifier.value = _isExpandedNotifier.value ? _maxHeight : widget.height;

    _isDraggingNotifier.value = false;
  }
}

Future showAppBottomSheet({
  required BuildContext context,
  double? height,
  VoidCallback? onBack,
  String? buttonLabel,
  VoidCallback? onButtonPressed,
  WidgetBuilder? childBuilder,
  double borderRadius = 32,
  bool extendOnDraggingUp = false,
  bool closeKeyboardOnBodyTap = true,
  bool wrapInAppBottomSheet = true,
  bool useRootNavigator = true,
}) {
  final double maxWidth = context.screenWidth;
  final double maxHeight = context.screenHeightWithoutAppBar;

  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useRootNavigator: useRootNavigator,
    constraints: BoxConstraints(maxWidth: maxWidth, maxHeight: maxHeight),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(borderRadius)),
    ),
    builder: (_) {
      if (!wrapInAppBottomSheet) {
        return childBuilder?.call(context) ?? const SizedBox();
      }

      return AppBottomSheet(
        height: height,
        maxHeight: maxHeight,
        onBack: onBack,
        buttonLabel: buttonLabel,
        onButtonPressed: onButtonPressed,
        extendOnDraggingUp: extendOnDraggingUp,
        closeKeyboardOnBodyTap: closeKeyboardOnBodyTap,
        child: childBuilder?.call(context),
      );
    },
  );
}
