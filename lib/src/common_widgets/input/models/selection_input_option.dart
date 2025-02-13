import 'package:flutter/material.dart';

class SelectionInputOption {
  final String Function(BuildContext context) labelText;
  final String? value;
  final Widget? icon;

  const SelectionInputOption(this.labelText, {this.value, this.icon});
}
