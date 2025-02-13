import 'package:flutter/material.dart';

import 'package:flag/flag.dart';

import 'package:flutter_template/src/constants/widget_sizings.dart';
import 'package:flutter_template/src/providers/locale_provider.dart';
import 'package:flutter_template/src/providers/user_provider.dart';
import 'package:flutter_template/src/utils/extensions/extensions.dart';

class _LocaleOption {
  final String labelText;
  final String value;
  final Flag flag;

  const _LocaleOption(this.labelText, this.value, this.flag);
}

class LocaleButton extends StatefulWidget {
  const LocaleButton({super.key});

  @override
  State<LocaleButton> createState() => _LocaleButtonState();
}

class _LocaleButtonState extends State<LocaleButton> {
  final List<_LocaleOption> _localeOptions = [
    _LocaleOption('ქართული', 'ka', Flag.fromCode(FlagsCode.GE)),
    _LocaleOption('English', 'en', Flag.fromCode(FlagsCode.GB)),
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: context.colorScheme.surfaceContainer,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: ListenableBuilder(
        listenable: LocaleProvider.instance,
        builder: (_, __) => DropdownButton(
          value: LocaleProvider.instance.langCode,
          onChanged: _onDropdownValueChanged,
          isDense: true,
          padding: const EdgeInsets.fromLTRB(8, 6, 2, 6),
          iconSize: 28,
          underline: const SizedBox(),
          icon: const Icon(Icons.arrow_drop_down_rounded),
          menuWidth: 200,
          borderRadius: BorderRadius.circular(12),
          dropdownColor: context.colorScheme.surfaceContainer,
          selectedItemBuilder: (_) => _localeOptions.map((_LocaleOption option) {
            return Container(
              width: 32,
              height: 24,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
              clipBehavior: Clip.antiAlias,
              child: option.flag,
            );
          }).toList(),
          items: _localeOptions.map((_LocaleOption option) {
            return DropdownMenuItem<String>(
              value: option.value,
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 24,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(4)),
                    clipBehavior: Clip.antiAlias,
                    child: option.flag,
                  ),
                  Gaps.w10,
                  Text(option.labelText),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _onDropdownValueChanged(String? value) {
    if (value == null) {
      return;
    }

    LocaleProvider.instance.switchLocale(value);
    UserProvider.instance.selfUpdate(locale: value);
  }
}
