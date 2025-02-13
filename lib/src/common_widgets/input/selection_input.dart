import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/bottom_sheet/bottom_sheet.dart';
import 'package:flutter_template/src/common_widgets/input/models/selection_input_option.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';
import 'package:flutter_template/src/utils/input_utils/input_utils.dart';

export 'package:flutter_template/src/common_widgets/input/models/selection_input_option.dart';

class SelectionInput<T> extends StatefulWidget {
  final ValueNotifier<int?> selectedIndexNotifier;
  final List<SelectionInputOption> options;
  final String labelText;
  final String? helperText;
  final String? errorText;
  final bool enabled;
  final bool isRequired;
  final void Function(int selectedIndex)? onSubmit;

  /// If null, defaults to `context.screenHeightWithoutAppBar * 0.5`.
  final double? bottomSheetHeight;

  const SelectionInput({
    required this.selectedIndexNotifier,
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
  State<SelectionInput<T>> createState() => _SelectionInputState<T>();
}

class _SelectionInputState<T> extends State<SelectionInput<T>> {
  final TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _handleSelectionValueChange());
    widget.selectedIndexNotifier.addListener(_handleSelectionValueChange);
  }

  @override
  void dispose() {
    widget.selectedIndexNotifier.removeListener(_handleSelectionValueChange);
    _textController.dispose();
    super.dispose();
  }

  void _handleSelectionValueChange() {
    final int? selectedOptionIndex = widget.selectedIndexNotifier.value;

    if (selectedOptionIndex == null) {
      _textController.value = TextEditingValue.empty;
      return;
    }

    final SelectionInputOption selectedOption = widget.options[selectedOptionIndex];

    _textController.value = TextEditingValue(text: selectedOption.labelText(context));
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

    showAppBottomSheet(
      context: context,
      extendOnDraggingUp: true,
      height: widget.bottomSheetHeight ?? context.screenHeightWithoutAppBar * 0.5,
      childBuilder: (BuildContext ctx) => Flexible(
        child: ListView.builder(
          itemCount: widget.options.length,
          itemBuilder: (_, int i) {
            final SelectionInputOption option = widget.options[i];

            return ListTile(
              onTap: () {
                widget.selectedIndexNotifier.value = i;
                widget.onSubmit?.call(i);
                ctx.pop();
              },
              leading: option.icon,
              minLeadingWidth: 32,
              horizontalTitleGap: 12,
              title: Text(option.labelText(context)),
              trailing: i == widget.selectedIndexNotifier.value
                  ? Icon(
                      Icons.check_circle_rounded,
                      color: context.colorScheme.primary,
                      size: 28,
                    )
                  : null,
            );
          },
        ),
      ),
    );
  }
}
