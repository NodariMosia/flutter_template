import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/bottom_sheet/bottom_sheet.dart';
import 'package:flutter_template/src/common_widgets/input/models/selection_input_option.dart';
import 'package:flutter_template/src/common_widgets/listenable_builder/rerender_callback_builder.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';
import 'package:flutter_template/src/utils/input_utils/input_utils.dart';

export 'package:flutter_template/src/common_widgets/input/models/selection_input_option.dart';

class MultiSelectionInput<T> extends StatefulWidget {
  final ValueNotifier<Set<int>> selectedIndicesNotifier;
  final List<SelectionInputOption> options;
  final String labelText;
  final String? helperText;
  final String? errorText;
  final bool enabled;
  final bool isRequired;
  final void Function(Set<int> selectedIndices)? onSubmit;

  /// If null, defaults to `context.screenHeightWithoutAppBar * 0.5`.
  final double? bottomSheetHeight;

  const MultiSelectionInput({
    required this.selectedIndicesNotifier,
    required this.options,
    required this.labelText,
    this.helperText,
    this.errorText,
    this.enabled = true,
    this.isRequired = false,
    this.onSubmit,
    this.bottomSheetHeight,
    super.key,
  });

  @override
  State<MultiSelectionInput<T>> createState() => _MultiSelectionInputState<T>();
}

class _MultiSelectionInputState<T> extends State<MultiSelectionInput<T>> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleSelectionValueChange());
    widget.selectedIndicesNotifier.addListener(_handleSelectionValueChange);
  }

  @override
  void dispose() {
    widget.selectedIndicesNotifier.removeListener(_handleSelectionValueChange);
    _textController.dispose();
    super.dispose();
  }

  void _handleSelectionValueChange() {
    if (widget.selectedIndicesNotifier.value.isEmpty) {
      _textController.value = TextEditingValue.empty;
      return;
    }

    final StringBuffer sb = StringBuffer();

    for (final int i in widget.selectedIndicesNotifier.value) {
      if (sb.isNotEmpty) {
        sb.write(', ');
      }
      sb.write(widget.options[i].labelText(context));
    }

    _textController.value = TextEditingValue(text: sb.toString());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.enabled ? _showOptions : null,
      child: TextFormField(
        controller: _textController,
        enabled: false,
        style: TextStyle(color: context.colorScheme.onSurface),
        decoration: InputDecoration(
          labelText: widget.labelText,
          helperText: widget.helperText,
          helperMaxLines: 3,
          errorText: widget.errorText,
          errorMaxLines: 3,
          suffixIcon: Icon(Icons.arrow_forward_ios_rounded, color: context.appColors.hint),
          disabledBorder: context.theme.inputDecorationTheme.border,
        ),
        validator: widget.isRequired ? InputValidators.required() : null,
      ),
    );
  }

  void _showOptions() {
    if (!widget.enabled) {
      return;
    }

    final Set<int> selectedIndices = {...widget.selectedIndicesNotifier.value};

    showAppBottomSheet(
      context: context,
      extendOnDraggingUp: true,
      height: widget.bottomSheetHeight ?? context.screenHeightWithoutAppBar * 0.5,
      buttonLabel: context.l10n.done,
      onButtonPressed: () {
        widget.selectedIndicesNotifier.value = selectedIndices;
        widget.onSubmit?.call(selectedIndices);
        context.pop();
      },
      childBuilder: (BuildContext ctx) => Flexible(
        child: ListView.builder(
          itemCount: widget.options.length,
          itemBuilder: (_, int i) {
            final SelectionInputOption option = widget.options[i];

            return RerenderCallbackBuilder(
              builder: (_, rerender, __) {
                final bool isSelected = selectedIndices.contains(i);

                return ListTile(
                  onTap: () {
                    isSelected ? selectedIndices.remove(i) : selectedIndices.add(i);
                    rerender();
                  },
                  leading: option.icon,
                  minLeadingWidth: 32,
                  horizontalTitleGap: 12,
                  title: Text(option.labelText(context)),
                  trailing: isSelected
                      ? Icon(
                          Icons.check_circle_rounded,
                          color: context.colorScheme.primary,
                          size: 28,
                        )
                      : null,
                );
              },
            );
          },
        ),
      ),
    );
  }
}
