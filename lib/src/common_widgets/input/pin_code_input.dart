import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

import 'package:flutter_template/src/constants/widget_sizings.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';
import 'package:flutter_template/src/utils/input_utils/input_utils.dart';

class PinCodeInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final int length;
  final bool enabled;
  final bool autofocus;
  final bool isSms;
  final String? errorText;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final InputValidator? validator;

  const PinCodeInput({
    required this.controller,
    this.focusNode,
    this.length = 6,
    this.enabled = true,
    this.autofocus = false,
    this.isSms = false,
    this.errorText,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    super.key,
  });

  @override
  State<PinCodeInput> createState() => _AppPinCodeTextFieldState();
}

class _AppPinCodeTextFieldState extends State<PinCodeInput> {
  static const double maxPinSize = 48.0;
  static const double maxSeparatorWidth = 8.0;
  static const double maxScreenSpaceRatioTakenByPins = 0.72;

  late final double pinWidthRatio = maxScreenSpaceRatioTakenByPins / widget.length;

  @override
  Widget build(BuildContext context) {
    final double availableScreenWidth = context.screenWidth - 2 * kHorizontalPagePadding;

    final double scaledPinWidth = availableScreenWidth * pinWidthRatio;
    final double pinWidth = math.min(scaledPinWidth, maxPinSize);

    final double scaledSeparatorWidth =
        (availableScreenWidth - (pinWidth * widget.length)) / (widget.length - 1);
    final double separatorWidth = math.min(scaledSeparatorWidth, maxSeparatorWidth);

    final TextStyle? defaultTextStyle = context.textTheme.headlineMedium?.copyWith(
      fontWeight: FontWeight.w400,
      height: 1,
    );

    PinTheme pinTheme(Color borderColor, [Color? textColor]) {
      return PinTheme(
        width: pinWidth,
        height: maxPinSize,
        textStyle: defaultTextStyle?.copyWith(color: textColor ?? context.colorScheme.onSurface),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: borderColor, width: 2)),
        ),
      );
    }

    return Pinput(
      controller: widget.controller,
      focusNode: widget.focusNode,
      length: widget.length,
      enabled: widget.enabled,
      autofocus: widget.autofocus,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      onCompleted: widget.onSubmitted,
      showCursor: true,
      enableSuggestions: false,
      textInputAction: TextInputAction.done,
      inputFormatters: [InputFormatters.verificationCodeFormatter],
      autofillHints: const [AutofillHints.oneTimeCode],
      defaultPinTheme: pinTheme(context.appColors.disabled),
      followingPinTheme: pinTheme(context.appColors.disabled),
      focusedPinTheme: pinTheme(context.colorScheme.primary),
      errorPinTheme: pinTheme(context.colorScheme.error),
      disabledPinTheme: pinTheme(context.appColors.disabled, context.appColors.disabled),
      separatorBuilder: (_) => SizedBox(width: separatorWidth),
      preFilledWidget: Text('0', style: defaultTextStyle?.copyWith(color: context.appColors.hint)),
      forceErrorState: widget.errorText != null,
      errorText: widget.errorText,
      errorTextStyle: context.theme.inputDecorationTheme.errorStyle,
      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      validator: widget.validator,
    );
  }
}
