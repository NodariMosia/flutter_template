import 'package:flutter/material.dart';

import 'package:flutter_template/src/utils/extensions/extensions.dart';
import 'package:flutter_template/src/utils/input_utils/input_utils.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool enabled;
  final bool autofocus;
  final TextInputAction? textInputAction;
  final void Function(String text)? onChanged;
  final void Function(String text)? onSubmitted;
  final String? labelText;
  final String? hintText;
  final String? helperText;
  final String? errorText;
  final InputValidator? validator;

  const PasswordInput({
    required this.controller,
    this.focusNode,
    this.enabled = true,
    this.autofocus = false,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.labelText,
    this.hintText,
    this.helperText,
    this.errorText,
    this.validator,
    super.key,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _isTextHidden = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: widget.enabled,
      autocorrect: false,
      enableSuggestions: false,
      obscureText: _isTextHidden,
      textInputAction: widget.textInputAction,
      keyboardType: TextInputType.visiblePassword,
      inputFormatters: [InputFormatters.passwordFormatter],
      validator: widget.validator,
      onChanged: widget.onChanged,
      onFieldSubmitted: widget.onSubmitted,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: widget.hintText,
        helperText: widget.helperText,
        errorText: widget.errorText,
        errorMaxLines: 3,
        suffixIcon: ExcludeFocus(
          child: Padding(
            padding: const EdgeInsets.only(right: 2),
            child: IconButton(
              onPressed: () => setState(() => _isTextHidden = !_isTextHidden),
              icon: Icon(_isTextHidden ? Icons.visibility_off_rounded : Icons.visibility_rounded),
              color: context.colorScheme.outline,
              style: IconButton.styleFrom(backgroundColor: Colors.transparent),
            ),
          ),
        ),
        suffixIconConstraints: const BoxConstraints(),
      ),
    );
  }
}
