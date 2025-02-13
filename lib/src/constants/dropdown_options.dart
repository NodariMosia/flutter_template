import 'package:flutter/material.dart';

import 'package:flutter_template/src/common_widgets/input/models/selection_input_option.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

abstract final class DropdownOptions {
  static final List<SelectionInputOption> themeModeOptions = [
    SelectionInputOption(
      (BuildContext context) => context.l10n.system,
      icon: const Icon(Icons.auto_mode_rounded, size: 28),
    ),
    SelectionInputOption(
      (BuildContext context) => context.l10n.light,
      icon: const Icon(Icons.light_mode_rounded, size: 28),
    ),
    SelectionInputOption(
      (BuildContext context) => context.l10n.dark,
      icon: const Icon(Icons.dark_mode_rounded, size: 28),
    ),
  ];
}
